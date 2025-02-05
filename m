Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B891FCFDA;
	Wed,  5 Feb 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779679; cv=none; b=RFfeMNE2uUyys9Yeq2Tp7P/Twky0oxLk10C+3EPA7qKKXqGLvgb4qmMa8+sBRCCrwSVIU5WEzf33P/XYlaslpCuEH5J67sCadUO4342iah52Dg5CPF8R2KwoF08mtqUw82d9mGoRuCrzfqRqotTzP61QxixRz74KDHjFZxifXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779679; c=relaxed/simple;
	bh=ZLBcxDR6xyrd7FW9e2RhDQ/iUci0Sz/wb6g01nZtAPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i95tUVXyKwkq+teMkJH3sX3y9hFaMOaAypYe0e/nrT/CFk94hJTWpu+4GU+8MopTnzWf+Np7wqEEKomxF6CUc6Axcf8dHJYhsfxdGKCmK/vFBhztBMclf1j2iIt75ViXGfUtOq143DhsILCj5JZIeQNjN5LsY18uaz3GO5ljEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kD3EEmwQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z03S6KP+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nA0RWJMm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6VZ2snRf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kD3EEmwQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z03S6KP+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nA0RWJMm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6VZ2snRf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C4B21F387;
	Wed,  5 Feb 2025 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738779674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIrv/Wrb80+l6c/3vehs+Bk6XWMbyIWde03DtyPmJqw=;
	b=kD3EEmwQwxPuGzQjygMxrJaAajc87zFKNPuVtRkU7fa0ounHZU4SoI8XxlgekJAJPYC8Qd
	hyP+ShXPSmYRJSQTHe9j6aiMBQ+Se/gN8sOqCpGwesgVT0KEfwXTB/2AP0gyO5dY5yn3t4
	ecZn8yUnLn1YKsVhYk3L+TjpGVcsVuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738779674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIrv/Wrb80+l6c/3vehs+Bk6XWMbyIWde03DtyPmJqw=;
	b=Z03S6KP++17a2vK3p6y+9tIp0MrNmyKPeCHzsjHGqckoRWZB/rOIpMm8fo3W0oaw5DN07d
	k66LSUxFpYPWn4BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nA0RWJMm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6VZ2snRf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738779673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIrv/Wrb80+l6c/3vehs+Bk6XWMbyIWde03DtyPmJqw=;
	b=nA0RWJMmRaY0oBVNBAFvzndEB3wmsbwawT2KKEBPs94dabIDyffrN5D4py9e6Q6yhuT2rD
	uRRHCXjgFgCqtoh0BeP2bCqb5B42iPOKdKDw+T6EnwsUcaOYK101c+hC4GxZvNCwjowCmK
	s6d0a2VG8X4YwQYt7JmEY+4Clu7Fi6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738779673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIrv/Wrb80+l6c/3vehs+Bk6XWMbyIWde03DtyPmJqw=;
	b=6VZ2snRfcvxuq6bWkNzrzkBTTBs+cAxRJ1s39lmGVRp5KDrbBfHMLDJMF7ydOWoqEgM6J/
	DlBmjbRr03EdEZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F0BE13694;
	Wed,  5 Feb 2025 18:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jZT/Ehmso2eLVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Feb 2025 18:21:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C983A28E9; Wed,  5 Feb 2025 19:21:04 +0100 (CET)
Date: Wed, 5 Feb 2025 19:21:04 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	kees@kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <r7aylhww6ssce4uk4drib5c7awf6kcdgo5rzorbi3mve723hu6@6p7ij7t44ejq>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rbk7j4upftqdugse"
Content-Disposition: inline
In-Reply-To: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
X-Rspamd-Queue-Id: 6C4B21F387
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,gmail.com,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[48a99e426f29859818c0];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO


--rbk7j4upftqdugse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 04-02-25 01:46:28, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1258aeb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
> dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15825724580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1658aeb0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7c2919610764/mount_0.gz
> 
> The issue was bisected to:
> 
> commit bae80473f7b0b25772619e7692019b1549d4a82c
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Wed Nov 20 11:20:35 2024 +0000
> 
>     ext4: use inode_set_cached_link()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1248c3df980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1148c3df980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1648c3df980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")

Please check attached patch:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--rbk7j4upftqdugse
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Verify-fast-symlink-length.patch"

From df00b84402fb67d94a9eb6b86633092983cb388c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 5 Feb 2025 19:02:35 +0100
Subject: [PATCH] ext4: Verify fast symlink length

Verify fast symlink length stored in inode->i_size matches the string
stored in the inode to avoid surprises from corrupted filesystems.

Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..fbda5a67f7f9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
 		} else if (ext4_inode_is_fast_symlink(inode)) {
 			inode->i_op = &ext4_fast_symlink_inode_operations;
-			nd_terminate_link(ei->i_data, inode->i_size,
-				sizeof(ei->i_data) - 1);
+			if (inode->i_size == 0 ||
+			    inode->i_size >= EXT4_N_BLOCKS * 4 ||
+			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
+								inode->i_size) {
+				ext4_error_inode(inode, function, line, 0,
+					"invalid fast symlink length %llu",
+					 (unsigned long long)inode->i_size);
+				ret = -EFSCORRUPTED;
+				goto bad_inode;
+			}
 			inode_set_cached_link(inode, (char *)ei->i_data,
 					      inode->i_size);
 		} else {
-- 
2.43.0


--rbk7j4upftqdugse--
