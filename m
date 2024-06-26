Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F111A92F;
	Wed, 26 Jun 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416490; cv=none; b=fc3O5HtH/tWo23PZyRgiwfAOB6gTV3uEkH/8YnYKVZ99RhEXX4kOaOiVufLgB+d1TH/+Zcmjj1akOKFrmA/eOVI1Df67fJyswSQhPRw4DUnaVLPIXxd9WeeEp7YQvCci37N/VXJuISv3ntuWXMpoB7ItJJnjsrNgQSNxa9zvyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416490; c=relaxed/simple;
	bh=GPHvwfVOsOpJ3F4HSr4EpYRzSsypkz6TSUJoNBbhErs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcAKdGOWF8IdGO6gKNQlyidaK2sED0J0wz51K8r6hj7GqgulMjxkYcuOGr2Cf774zT5H4ZVxFs/s4QjcFjy2GxLxsvVEbJYG87SBl/vWjZ7jgOcMHy11NSjWFeLNGSX7gtT2N/PUYNrd/HiJDtnXechDvEQvKnj18pnikLAhKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EWW4oUXI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EWW4oUXI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=I2mKrncqrxQxg3yWqxHlilhT6KiFqVB2cixTKCsRVuo=; b=EWW4oUXIHM0thFAE
	OnOspGfMc5HhlJOuzLrrBhNlPk6akWkMVt3TsIX0pjRaY8WLYAVaGJDlmdi7G0rMunVOWOUUnCFY8
	OsjY0ijPo29+VcDpnMt0AGuFvIvcKLPh9HerZpeiyHV7G4bEwEmcY9VFKlPTmCb+EokGSL8lWpKXZ
	H0S/Nglapsu7JmK6sO0mhlSYVHWw5l/zzAI7Lb+PVRImo23SzBiYJVEXZkeFsd9j/0SeGYODksSBz
	oUQpg9wZiRTuF5HF8odDl0CWH+PfcjuRhRLsE66j/b0KAYk4rpBQ16EQhbsdVtJLTcNs0Zc8K6vDD
	dcQqCes7LIPx59myxQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sMUlt-008VLV-1J;
	Wed, 26 Jun 2024 15:41:21 +0000
Date: Wed, 26 Jun 2024 15:41:21 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: sudipm.mukherjee@gmail.com, sudip.mukherjee@codethink.co.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] parport: Cleanup some pre-devmodel code
Message-ID: <Znw2oRnqaZ39aXzQ@gallifrey>
References: <20240502154823.67235-1-linux@treblig.org>
 <ZkXj9Ip3DoUAe1wt@gallifrey>
 <Zl3_5MzTNqIiXM_C@gallifrey>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zl3_5MzTNqIiXM_C@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:39:43 up 49 days,  2:53,  1 user,  load average: 0.06, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > There are some remenants of the pre-devmodel code
> > > still in the parport drivers; try and clean some of them out.
> > 
> > Ping!
> 
> Ping^2.

Ping^3

(Added Sudip's other email address, and also cc'd linux-hardening)

Dave

> Dave
> 
> > Dave
> > 
> > > This series should have no visible change, all the drivers
> > > already use the devmodel, it's just removing the flags
> > > that say that, and cleaning out no longer used function pointers.
> > > (To me the most useful bit is removing the no longer used
> > > 'attach' pointer, so if you've got code that's trying to use
> > > it you'll get educated).
> > > 
> > > Trivially tested in qemu, I can still write to the lp;
> > > 
> > > Also checked with grep -r 'struct parport_driver' . -A 9
> > > to see if I've missed any.
> > > 
> > > (I found this while dragging the out-of-tree ppscsi code
> > > into working on head, so that I could use my prehistoric
> > > HP PP scanner)
> > > 
> > > Dave
> > > 
> > > Dr. David Alan Gilbert (3):
> > >   parport: Remove 'drivers' list
> > >   parport: Remove attach function pointer
> > >   parport: Remove parport_driver.devmodel
> > > 
> > >  drivers/ata/pata_parport/pata_parport.c  | 1 -
> > >  drivers/auxdisplay/ks0108.c              | 1 -
> > >  drivers/auxdisplay/panel.c               | 1 -
> > >  drivers/char/lp.c                        | 1 -
> > >  drivers/char/ppdev.c                     | 1 -
> > >  drivers/i2c/busses/i2c-parport.c         | 1 -
> > >  drivers/input/joystick/db9.c             | 1 -
> > >  drivers/input/joystick/gamecon.c         | 1 -
> > >  drivers/input/joystick/turbografx.c      | 1 -
> > >  drivers/input/joystick/walkera0701.c     | 1 -
> > >  drivers/input/serio/parkbd.c             | 1 -
> > >  drivers/net/hamradio/baycom_epp.c        | 1 -
> > >  drivers/net/hamradio/baycom_par.c        | 1 -
> > >  drivers/net/plip/plip.c                  | 1 -
> > >  drivers/parport/daisy.c                  | 1 -
> > >  drivers/parport/share.c                  | 9 ---------
> > >  drivers/pps/clients/pps_parport.c        | 1 -
> > >  drivers/pps/generators/pps_gen_parport.c | 1 -
> > >  drivers/scsi/imm.c                       | 1 -
> > >  drivers/scsi/ppa.c                       | 1 -
> > >  drivers/spi/spi-butterfly.c              | 1 -
> > >  drivers/spi/spi-lm70llp.c                | 1 -
> > >  include/linux/parport.h                  | 6 ------
> > >  sound/drivers/mts64.c                    | 1 -
> > >  sound/drivers/portman2x4.c               | 1 -
> > >  25 files changed, 38 deletions(-)
> > > 
> > > -- 
> > > 2.44.0
> > > 
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
