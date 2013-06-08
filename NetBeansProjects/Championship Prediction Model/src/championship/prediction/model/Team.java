package championship.prediction.model;

public class Team {

    public final int team;
    public double opr;
    public double autoOpr;

    public Team(int team, double opr, double autoOpr) {
        this.team = team;
        this.opr = opr;
        this.autoOpr = autoOpr;
    }
}