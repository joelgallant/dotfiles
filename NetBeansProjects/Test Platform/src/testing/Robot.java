package testing;

import edu.wpi.first.wpilibj.IterativeRobot;
import edu.wpi.first.wpilibj.Victor;

public class Robot extends IterativeRobot {

    Victor v = new Victor(7);

    public void teleopPeriodic() {
        v.set(1);
    }
}
