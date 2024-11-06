/*
 * (c) 2013 InfinityArts
 * All codes are for use only in HiddenProject
 */
package augoeides.requests;

import augoeides.dispatcher.IRequest;
import augoeides.dispatcher.RequestException;
import augoeides.world.World;
import it.gotoandplay.smartfoxserver.data.Room;
import it.gotoandplay.smartfoxserver.data.User;

/**
 *
 * @author Atheros
 */
public class Hi implements IRequest {

    @Override
    public void process(String[] params, User user, World world, Room room) throws RequestException {
        world.send(new String[]{"hi"}, user);
    }

}
