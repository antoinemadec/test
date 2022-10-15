import sys
import math


def get_dist(x,y):
    return (x**2 + y**2)**0.5


def get_angle(v0, v1):
    dot_prod = v0[0] * v1[0] + v0[1] * v1[1]
    m = get_dist(v0[0], v0[1]) * get_dist(v1[0], v1[1])
    return math.degrees(math.acos(dot_prod/m)) if m != 0 else 0


def get_pod_dist(p, target_x, target_y):
    return get_dist(target_x-p['x'], target_y-p['y'])


def get_pod_angle(p, target_x, target_y):
    return get_angle((p['orientation_x'], p['orientation_y']), (target_x-p['x'], target_y-p['y']))


def get_pod_thrust(p, target_x, target_y):
    target_angle = get_pod_angle(p, target_x, target_y)
    target_dist = get_pod_dist(p, target_x, target_y)
    abs_deg = abs(target_angle)

    if abs_deg >= 90:
        t = 0
    elif target_dist < 1200 and p['cp_dist'] < 1000 and p['speed'] < 210 and target_angle > 75:
        print(f"{p['name']=} STUCK", file=sys.stderr, flush=True)
        t = 50
    else:
        t = int(100*abs(math.cos(math.radians(abs_deg/4))))
    return t if t < 98 else "BOOST"


def compute_pods_info(pods, prev_pods):
    global lap_nb
    global checkpoints
    for pod_name in ['pod1', 'pod2', 'op1', 'op2']:
        p = pods[pod_name]
        prev_p = prev_pods[pod_name] if prev_pods else None
        # defaults
        p.setdefault('name', pod_name)
        p.setdefault('lap_cnt', 0)
        p.setdefault('final_cp', False)
        # checkpoint
        p['cp_x'], p['cp_y'] = checkpoints[p['cp_id']]
        p['cp_p1_x'], p['cp_p1_y'] = checkpoints[(p['cp_id']+1) % len(checkpoints)]
        p['cp_dist'] = get_dist(p['x']-p['cp_x'], p['y']-p['cp_y'])
        p['orientation_x'], p['orientation_y'] = math.cos(math.radians(p['angle'])), math.sin(math.radians(p['angle']))
        # lap
        if prev_p and prev_p['cp_id'] == len(checkpoints) - 1 and p['cp_id'] == 0:
            p['lap_cnt'] += 1
            if p['lap_cnt'] == lap_nb:
                p['final_cp'] = True
        # misc
        p['speed'] = get_dist(p['vx'], p['vy'])

    # ranking
    l = list(pods.values())
    l = sorted(pods.values(), key = lambda p: (-p['lap_cnt'], -p['cp_id'], p['cp_dist']))
    for i,p in enumerate(l):
        pods[p['name']]['rank'] = i+1


def print_pods(pods):
    best_op = 'op1' if pods['op1']['rank'] < pods['op2']['rank'] else 'op2'
    worst_op = 'op1' if best_op == 'op2' else 'op2'
    best_pod = 'pod1' if pods['pod1']['rank'] < pods['pod2']['rank'] else 'pod2'
    worst_pod = 'pod1' if best_pod == 'pod2' else 'pod2'

    for name in ["pod1", "pod2"]:
        p = pods[name]
        # blocker
        if name == worst_pod:
            op = pods[best_op]
            op_cp_dist = get_pod_dist(p, op['cp_x'], op['cp_y'])
            if op_cp_dist < 1500:
                target_x = op['x'] + 2*op['vx']
                target_y = op['y'] + 2*op['vy']
            else:
                target_x = op['cp_x'] - 4*p['vx']
                target_y = op['cp_y'] - 4*p['vy']
            thrust = get_pod_thrust(p, target_x, target_y)
        # racer
        else:
            op = pods[worst_op]
            op_to_cp_dist = get_dist(p['cp_x']-op['x'], p['cp_y']-op['y'])
            op_is_in_cp = op_to_cp_dist < 1000
            # worst op is blocking
            if op_is_in_cp and op['rank'] > p['rank'] and op['speed'] < 200:
                target_x = p['cp_x']
                target_y = p['cp_y']
            else:
                target_x = p['cp_x'] - int(3.5*p['vx'])
                target_y = p['cp_y'] - int(3.5*p['vy'])
                target_dist = get_pod_dist(p, target_x, target_y)
                # aim for (n+1)th checkpoint when close enough to (n)th
                if target_dist < 700:
                    if p['final_cp']:
                        target_x = p['cp_x']
                        target_y = p['cp_y']
                    else:
                        target_x = p['cp_p1_x'] - 4*p['vx']
                        target_y = p['cp_p1_y'] - 4*p['vy']
            thrust = get_pod_thrust(p, target_x, target_y)

        # SHIELD
        dist_op1 = get_pod_dist(p, pods['op1']['x'], pods['op1']['y'])
        dist_op2 = get_pod_dist(p, pods['op2']['x'], pods['op2']['y'])
        closest_op = 'op1' if dist_op1 < dist_op2 else 'op2'
        dist_closest_op = min(dist_op1, dist_op2)
        relative_speed_closest_op = get_dist(p['vx']-pods[closest_op]['vx'], p['vy']-pods[closest_op]['vy'])
        print(f"{p['name']=} {closest_op=} {dist_closest_op=} {relative_speed_closest_op=}", file=sys.stderr, flush=True)
        if dist_closest_op < 1550 and relative_speed_closest_op > 700:
            print(f"SHIELD", file=sys.stderr, flush=True)
            thrust = "SHIELD"

        print(f"{target_x} {target_y} {thrust}")


# game loop
lap_nb = [int(i) for i in input().split()][0]
cp_nb = [int(i) for i in input().split()][0]
checkpoints = []
for _ in range(cp_nb):
    checkpoints.append([int(i) for i in input().split()])

prev_pods = {}
pods = {}
while True:
    for pod_name in ['pod1', 'pod2', 'op1', 'op2']:
        pod = pods.get(pod_name, {})
        for k,v in zip(['x', 'y', 'vx', 'vy', 'angle', 'cp_id'], [int(i) for i in input().split()]):
            pod[k] = v
        pods[pod_name] = pod

    compute_pods_info(pods, prev_pods)
    for pod_name in ['pod1', 'pod2', 'op1', 'op2']:
        pod = pods.get(pod_name, {})

    for pod_name in ['pod1', 'pod2', 'op1', 'op2']:
        prev_pods[pod_name] = pods[pod_name].copy()

    print_pods(pods)
