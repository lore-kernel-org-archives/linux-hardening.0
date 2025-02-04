Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFE14F9D6;
	Tue,  4 Feb 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683013; cv=none; b=PxrjNRQlAuktPjsJrpxcGDvFXO0GuPR3liCuM8I+6jrVVRSA3lAHDpXaQ2zfkYs8uMjI40Jho3J9NHhP2UFWHargDfKad1kkRrXhLFyF0IxkVloqfW/hbSSsfu1CYYHS+ZMuxaUtVIebYZ7Ntrup6Hzt6Kk/Cp9F1ByjG6li2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683013; c=relaxed/simple;
	bh=u1FZ54R0O5S/HeyqDgM4tlKdRqkdUj3bRIO8nDvAQFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rskK7Xjel2QIAK/41d+IKyB/PGMj1HVpsKN8sCDt8BU+O3ITR+p8HnKc6AHPS+Es3ioqT8WAo37dAwf3SjC4eOUCfcwauRn4XLSxRdivC0E/gvxym8Ce5ZrIGNIBT7m0ehmnFSnlcd17+Kr234iMmxPj0IalkN6c3L7OuM5QisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXRwN3+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXRwN3+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9835DC4CEDF;
	Tue,  4 Feb 2025 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683012;
	bh=u1FZ54R0O5S/HeyqDgM4tlKdRqkdUj3bRIO8nDvAQFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXRwN3+K38LnZd+JYDmSua/WO4AB6KFUC3CJY3ASq2Bdv4+dijrZw0CR34hP2edbY
	 wZCsqcDtWolE7doBm6MpTV6Nrl3D9CXsSzQ7DWTt8iBWV+q3HRQUEHOWLu+IGKgwGw
	 YsRvv37U9oCv8/GRbskoivDxuLWDzl3rT8m3vfTL+fDwLj7/OXSTtMuQZ5pf7nTSoN
	 Fve01jM2J2J/ARIoGEqcxJgB5hTR3L0ab5JT6W6HCgn4xF8kh238VjfNrM7ISpBlmg
	 jcYN/dWDbsI9awBV1AJKFr9pUNU5FGX/kj4+GNw5EcuwI4IZIJ4MAvH3J0gV0meWLl
	 sp/FgqS5s/8AQ==
Date: Tue, 4 Feb 2025 07:30:08 -0800
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>,
	Theodore Ts'o <tytso@mit.edu>, akpm@linux-foundation.org,
	brauner@kernel.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <202502040717.FCEFDB7E0@keescook>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
 <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>

On Tue, Feb 04, 2025 at 12:38:30PM +0100, Mateusz Guzik wrote:
> On Tue, Feb 4, 2025 at 10:46 AM syzbot
> <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com> wrote:
> >
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
> 
> This looks like a case of a deliberately corrupted image.
> 
> I added back a debug printk I used when writing the patch before. For
> correct cases it reports:
> 
> [   19.574861] __ext4_iget: inode ff18d9bec05977c8 [/etc/environment]
> i_size 16 strlen 16
> [   19.585987] __ext4_iget: inode ff18d9bed6f25c68
> [/etc/alternatives/awk] i_size 21 strlen 21
> [   19.590419] __ext4_iget: inode ff18d9bed6f24108 [/usr/bin/gawk]
> i_size 13 strlen 13
> [   19.592199] __ext4_iget: inode ff18d9bed6abeea8
> [libassuan.so.0.8.5] i_size 18 strlen 18
> [   19.593804] __ext4_iget: inode ff18d9bed6f29368
> [libsigsegv.so.2.0.7] i_size 19 strlen 19
> 
> etc.
> 
> However, the bogus case is:
> [   52.161476] __ext4_iget: inode ff18d9bed1cc2a38
> [/tmp/syz-imagegen43743633/file0/file0] i_size 131109
> strlen 37
> 
> That is i_size is out of sync with strlen.
> 
> Prior to my patch this happened to work because the copying was in
> fact issuing strlen to find the size every time.
> 
> Given this code in fs/ext4/inode.c:
>   5008                 } else if (ext4_inode_is_fast_symlink(inode)) {
>   5009                         inode->i_op = &ext4_fast_symlink_inode_operations;
>   5010                         nd_terminate_link(ei->i_data, inode->i_size,
>   5011                                 sizeof(ei->i_data) - 1);
> 
> To me this looks like a pre-existing bug in ext4 which just happened

This gets clamped to i_data size, though, so I don't see a bug. Is there
still a code path where i_size is getting used? It looks like the buffer
overflow was introduced with bae80473f7b0 ("ext4: use inode_set_cached_link()"),
more details below...

> to get exposed with:
> 
>   5012                         inode_set_cached_link(inode, (char *)ei->i_data,
>   5013                                               inode->i_size);

The sanity checker said:
> usercopy: Kernel memory exposure attempt detected from SLUB object 'ext4_inode_cache' (offset 0, size 176)!

The cache was created to make only the i_data field visible:

        ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
                                sizeof(struct ext4_inode_info), 0,
                                SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
                                offsetof(struct ext4_inode_info, i_data),
                                sizeof_field(struct ext4_inode_info, i_data),
                                init_once);

which is 15 bytes, at offset 0:

struct ext4_inode_info {
        __le32  i_data[15];     /* unconverted */
        __u32   i_dtime;

So, yes, this seems like a buffer overflow caught by usercopy, where the
bug was as described above. I don't think there was an existing flaw in
ext4, though?

> However, if the strlen thing is indeed the source of truth, the
> inode_set_cached_link call can be trivially patched to use it instead
> of i_size.

Agreed. Please CC me and I can review it. :)

-Kees

-- 
Kees Cook
