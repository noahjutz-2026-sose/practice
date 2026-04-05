1. Ausgabe erklären

Parent schreibt und Child liest von shared memory, ohne Synchronisation.

2. Sleep vom Kind entfernen

Kind wartet nicht und gibt sofort 10x Inhalt von shared memory aus.

3. Sleep vom Parent entfernen

Parent wartet nicht und überschreibt sofort shared memory mit 9.

4. Spinlock erklären

Wenn beide Prozesse beim Lesen/Schreiben einen Lock beanspruchen müssen, können sie nicht gleichzeitig Lesen/Schreiben. Das löst aber nicht das Synchronisierungsproblem. Mit Sperrbedingung oder Queue lösbar.
