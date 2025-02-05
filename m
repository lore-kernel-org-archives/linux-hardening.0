Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F71FFC4D;
	Wed,  5 Feb 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780778; cv=none; b=dgwmsIjuuapEURbkycH4s/wLCuTHCpj6Z2K1puu9rpSUkkybAtdwM5FmNE2oWwHJnCTob7VDin4PX6me1TEVoOd2BDDW3rH8S6tG9bb6J1tFJS4F4JVeimh9l0BXmBgi4JgnTnqImjW4MA7mR4DzU0rer9ly3JCkzeFaDwitRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780778; c=relaxed/simple;
	bh=K2Dm4iFRSM/Ob4Zyy6ItdDl5CKpoNAwUnRnTz4l28l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD1HFL8letRuYmB0HW63LSTpExuV7HtG5IArPk4GIpo/JUqya4fvVp1ygDKeaSN8LTmPyGUDCZTUaYYRvfiFVduzsR1t5+PWQPpfNSIWYewmM4F+WlT8+y/BEh7QWt53ltmFzp8yvF7lbSa7nbfamjixPB11TekRUr74N3gWAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5vsaVc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5vsaVc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08129C4CEDD;
	Wed,  5 Feb 2025 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780778;
	bh=K2Dm4iFRSM/Ob4Zyy6ItdDl5CKpoNAwUnRnTz4l28l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5vsaVc2+MQLeEBLEtrCNvUC26aT53lFfJAGYd5uiPWIpUlkru1JOcOqRDZ+HbkdN
	 yjmlFavIzD06qZDtRMicoI05/5a3ucDsIgDyc2303EsqmhFIc4J61UINqigTmq87a3
	 70hkGNuhcmXg6QRvPzM9WqwsfyB/7k+XfW13zr53Uf8wOJKu+d0ePgY+8TlLHDSyRs
	 aetzP19bINzGdfCAHDS3db6bx4Y42/c7WS1y9EL8j7vpZZ+gfqH18htEGb2EadKMy/
	 Rgsq+ejnIoOM2Ln3CP63tbrlwttDctTT+Im6xmJUdqHRWJLYTaoIdp8v+GnLBpAYnR
	 eiC5ySU9OwXBQ==
Date: Wed, 5 Feb 2025 10:39:37 -0800
From: Kees Cook <kees@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, brauner@kernel.org,
	gustavoars@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjguzik@gmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <202502051031.2CF8D96392@keescook>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
 <r7aylhww6ssce4uk4drib5c7awf6kcdgo5rzorbi3mve723hu6@6p7ij7t44ejq>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r7aylhww6ssce4uk4drib5c7awf6kcdgo5rzorbi3mve723hu6@6p7ij7t44ejq>

On Wed, Feb 05, 2025 at 07:21:04PM +0100, Jan Kara wrote:
> On Tue 04-02-25 01:46:28, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1258aeb0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=48a99e426f29859818c0
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15825724580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1658aeb0580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/7c2919610764/mount_0.gz
> > 
> > The issue was bisected to:
> > 
> > commit bae80473f7b0b25772619e7692019b1549d4a82c
> > Author: Mateusz Guzik <mjguzik@gmail.com>
> > Date:   Wed Nov 20 11:20:35 2024 +0000
> > 
> >     ext4: use inode_set_cached_link()
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1248c3df980000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1148c3df980000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1648c3df980000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> > Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> 
> Please check attached patch:
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From df00b84402fb67d94a9eb6b86633092983cb388c Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 5 Feb 2025 19:02:35 +0100
> Subject: [PATCH] ext4: Verify fast symlink length
> 
> Verify fast symlink length stored in inode->i_size matches the string
> stored in the inode to avoid surprises from corrupted filesystems.
> 
> Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..fbda5a67f7f9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>  		} else if (ext4_inode_is_fast_symlink(inode)) {
>  			inode->i_op = &ext4_fast_symlink_inode_operations;
> -			nd_terminate_link(ei->i_data, inode->i_size,
> -				sizeof(ei->i_data) - 1);
> +			if (inode->i_size == 0 ||
> +			    inode->i_size >= EXT4_N_BLOCKS * 4 ||

This took me a while to understand. ei->i_data is u32[15]. It looks like
EXT4_N_BLOCKS is also 15. I feel like it would be much more readable to
have the above check be:

			    inode->i_size >= sizeof(ei->i_data) ||

instead of using a literal "4" for sizeof(u32) as "4", and having a
EXT4_N_BLOCKS standing in for the literal "15" in i_data.
sizeof(ei->i_data) is precisely what is being checked, so why not use
it?

And while at it, the definition of i_data could be adjusted to to use
EXT4_N_BLOCKS, e.g.:

struct ext4_inode_info {
        __le32  i_data[EXT4_N_BLOCKS];     /* unconverted */

?

> +			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> +								inode->i_size) {
> +				ext4_error_inode(inode, function, line, 0,
> +					"invalid fast symlink length %llu",
> +					 (unsigned long long)inode->i_size);
> +				ret = -EFSCORRUPTED;
> +				goto bad_inode;
> +			}

But regardless, yes, the math checks out, and looks correct to me.

>  			inode_set_cached_link(inode, (char *)ei->i_data,
>  					      inode->i_size);
>  		} else {
> -- 
> 2.43.0
> 


-Kees

-- 
Kees Cook
