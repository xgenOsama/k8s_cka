## Kubernetes Node Affinity
Node affinity defines under which circumstances a pod should schedule to a node. There are two types of node affinity:

# Hard affinity—also known as required node affinity.
Defined in the pod template
underspec: affinity:nodeAffinity:requiredDuringSchedulingIgnoredDuringExecution. This specifies conditions that a node must meet for a pod to schedule to it.

# Soft affinity—also known as preferred known affinity.
 Defined in the pod template under spec:affinity:nodeAffinity:preferredDuringSchedulingIgnoredDuringExecution. This specifies conditions that a node should preferably meet, but if they are not present, it is still okay to schedule the pod (as long as hard affinity criteria are met).
Both types of node affinity use logical operators including (In, NotIn, Exists, and DoesNotExist).

It is a good idea to define both hard and soft affinity rules for the same pod. This makes scheduling more flexible and easier to control across a range of operational situations.

## Kubernetes Inter-Pod Affinity
Inter-pod affinity lets you specify that certain pods should only schedule to a node together with other pods. This enables various use cases where collocation of pods is important, for performance, networking, resource utilization, or other reasons.

Pod affinity works similarly to node affinity:

Supports hard and soft affinity via the spec:affinity:podAffinity field of the pod template.
Uses the same logical operators.
The Kubernetes scheduler evaluates pods currently running on a node, and if they meet the conditions, it schedules the new pod on the node.