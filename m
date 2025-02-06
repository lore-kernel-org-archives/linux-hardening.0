Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C0376;
	Thu,  6 Feb 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835017; cv=none; b=V77BDbcSNgFWLOK/BjDFPhNq8+8MPKCUMEkQc+TPmBmXb198L/TUgGTFubAKIKOHYx8oLarl53XUZkEMmnd10Ns6B/PrfV18uYbcV9pPUG5STWB4E3zH3B2m9swX+zj+vO1Fn1jORi5W6/hcSth0hasy1bH5ocf98goZ4Qh7TPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835017; c=relaxed/simple;
	bh=8eyl0VzZgoiNvO1SiHEm8u1wtKboPWxSpz1MoUnM9IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx1+Pn75a5iKKNFcRSA12Za73nGCoBWCP2RDaWno/SVK3qBPjxImvSI5D2wG4tpssbDygX0sWimg0mheewpDAX4iqadjYfTFn9S2qW5C0q8ZctfoxaR5nxVGTPuphCB+WL7PdvgpeeslJ/G9Wo20e+RnDIeQH2jOs5QQKMM3fOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MbbuIhLm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCE50CTl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MbbuIhLm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCE50CTl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MbbuIhLm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCE50CTl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MbbuIhLm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCE50CTl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 076D91F381;
	Thu,  6 Feb 2025 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1SuLVgARcM8qAh8txDvor/72mo2wlLPZKKAQ1xZVPE=;
	b=MbbuIhLmLiiRG6ZOB8H+LYZaDNhs7EtLOb3nra3waVSoye2S3s7nqbYn1e2hn0SnJReNnZ
	Mhj7+KbUn1ADBYQpv6GvTkBhk2F7Z+/8A7JaIhHEXHk3lXGrciAXC8x9ali/HbtooqoihY
	uwBDU0FkNRoTYH0agZI3bR1m5v9Y/EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1SuLVgARcM8qAh8txDvor/72mo2wlLPZKKAQ1xZVPE=;
	b=XCE50CTl4r7Si0qs8/75D62T8CK5kYib5Dd4BJTPTlK0Cy0Lj4HkE+XRlh03sAJzyE0hPP
	lbRLzW1rEgrJUrBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1SuLVgARcM8qAh8txDvor/72mo2wlLPZKKAQ1xZVPE=;
	b=MbbuIhLmLiiRG6ZOB8H+LYZaDNhs7EtLOb3nra3waVSoye2S3s7nqbYn1e2hn0SnJReNnZ
	Mhj7+KbUn1ADBYQpv6GvTkBhk2F7Z+/8A7JaIhHEXHk3lXGrciAXC8x9ali/HbtooqoihY
	uwBDU0FkNRoTYH0agZI3bR1m5v9Y/EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1SuLVgARcM8qAh8txDvor/72mo2wlLPZKKAQ1xZVPE=;
	b=XCE50CTl4r7Si0qs8/75D62T8CK5kYib5Dd4BJTPTlK0Cy0Lj4HkE+XRlh03sAJzyE0hPP
	lbRLzW1rEgrJUrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC66413697;
	Thu,  6 Feb 2025 09:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rl60OT+EpGcFSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Feb 2025 09:43:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9E902A0889; Thu,  6 Feb 2025 10:43:23 +0100 (CET)
Date: Thu, 6 Feb 2025 10:43:23 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: Jan Kara <jack@suse.cz>, 
	syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, akpm@linux-foundation.org, brauner@kernel.org, 
	gustavoars@kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <gksdmj6duotvgrqrdf5omv5mlbvolw7jofsxqbnqvd2a5t7wpu@ukqah3y2dzqg>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
 <r7aylhww6ssce4uk4drib5c7awf6kcdgo5rzorbi3mve723hu6@6p7ij7t44ejq>
 <202502051031.2CF8D96392@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502051031.2CF8D96392@keescook>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,syzkaller.appspotmail.com,linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,gmail.com,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[48a99e426f29859818c0];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 05-02-25 10:39:37, Kees Cook wrote:
> On Wed, Feb 05, 2025 at 07:21:04PM +0100, Jan Kara wrote:
> > On Tue 04-02-25 01:46:28, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1258aeb0580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15825724580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1658aeb0580000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/7c2919610764/mount_0.gz
> > > 
> > > The issue was bisected to:
> > > 
> > > commit bae80473f7b0b25772619e7692019b1549d4a82c
> > > Author: Mateusz Guzik <mjguzik@gmail.com>
> > > Date:   Wed Nov 20 11:20:35 2024 +0000
> > > 
> > >     ext4: use inode_set_cached_link()
> > > 
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1248c3df980000
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1148c3df980000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1648c3df980000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > > Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> > 
> > Please check attached patch:
> > 
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> > From df00b84402fb67d94a9eb6b86633092983cb388c Mon Sep 17 00:00:00 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Wed, 5 Feb 2025 19:02:35 +0100
> > Subject: [PATCH] ext4: Verify fast symlink length
> > 
> > Verify fast symlink length stored in inode->i_size matches the string
> > stored in the inode to avoid surprises from corrupted filesystems.
> > 
> > Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> > Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 7c54ae5fcbd4..fbda5a67f7f9 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> >  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
> >  		} else if (ext4_inode_is_fast_symlink(inode)) {
> >  			inode->i_op = &ext4_fast_symlink_inode_operations;
> > -			nd_terminate_link(ei->i_data, inode->i_size,
> > -				sizeof(ei->i_data) - 1);
> > +			if (inode->i_size == 0 ||
> > +			    inode->i_size >= EXT4_N_BLOCKS * 4 ||
> 
> This took me a while to understand. ei->i_data is u32[15]. It looks like
> EXT4_N_BLOCKS is also 15. I feel like it would be much more readable to
> have the above check be:
> 
> 			    inode->i_size >= sizeof(ei->i_data) ||
> 
> instead of using a literal "4" for sizeof(u32) as "4", and having a
> EXT4_N_BLOCKS standing in for the literal "15" in i_data.
> sizeof(ei->i_data) is precisely what is being checked, so why not use
> it?

Yeah, I've used the tradidional way ext4 uses for this (e.g. in
ext4_inode_is_fast_symlink()) but I agree it is rather cryptic for those
not intimately familiar with ext4 on-disk format. Switched to the sizeof()
as you suggested. Thanks for review!

								Honza

> 
> And while at it, the definition of i_data could be adjusted to to use
> EXT4_N_BLOCKS, e.g.:
> 
> struct ext4_inode_info {
>         __le32  i_data[EXT4_N_BLOCKS];     /* unconverted */
> 
> ?
> 
> > +			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> > +								inode->i_size) {
> > +				ext4_error_inode(inode, function, line, 0,
> > +					"invalid fast symlink length %llu",
> > +					 (unsigned long long)inode->i_size);
> > +				ret = -EFSCORRUPTED;
> > +				goto bad_inode;
> > +			}
> 
> But regardless, yes, the math checks out, and looks correct to me.
> 
> >  			inode_set_cached_link(inode, (char *)ei->i_data,
> >  					      inode->i_size);
> >  		} else {
> > -- 
> > 2.43.0
> > 
> 
> 
> -Kees
> 
> -- 
> Kees Cook
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
