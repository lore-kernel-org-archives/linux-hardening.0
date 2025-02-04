Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D91D7985;
	Tue,  4 Feb 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684706; cv=none; b=bfT9pRWRE4s6v+Kw58ouJaEObKiEmb4EYuuJwUdralbtZPOIekmJAf4OV0x96YJM3VLaGE6U2Nk03wJGYlstBrCPL9dTSmojys4KjiOIWifgAsNT+8l+wAy5V2f+v8Q9tUe99Pj5X+KqtfM+DVlqXySyF/bRwJ8WieKLsnuHLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684706; c=relaxed/simple;
	bh=oSo3wyRsOMk1M9C/bumHQyesRaHNQpeTBqEZwnL1vLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubaqP0kY65QEQ0e8CyDWiYiN3tS1QNlA/xO/h8cAz+BvWo1/EFPFLtrihE6h3VePrFhxe+T1Fzk82HRfOTzrfDKm481wDSmEM9c4N5IZTzJPTe78oPXY36RGljxxhw1LgKjvXzGaYfQ1YtWcFjWINQb4rgj8hm4naLYjV5Qo6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8I8ky/s; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8I8ky/s"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dcca17340fso1294075a12.2;
        Tue, 04 Feb 2025 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684703; x=1739289503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uB2kJTb8QdOsUK0L7YFlrm67ABkU6a2AEVF7OP8woU=;
        b=h8I8ky/sfVUmVOXLEZ06bBeRh6gub/0k6dNAfNfOA3VJvkN13t5tAkfISUgyirxn22
         gblC4Ou22TPHKTju3VoapuAVH7v3Z6A8c7iqJ+i9BpFUAVdy8buuBcrVhSSYF4XM5gpv
         5q8y3YOUD3rO6QoA9/HCsnhK45VEBi/n18wouz/jCrOB32Iv/LbNcks7aCLpEUHncySf
         Wr/PRDg+MyaQVpS/9DTfh1NpvXA2IvliBdDUF7lthCPnzcqb3DHwtZ/SzvvNSR1Co8LG
         8+SukgtIFiFT6+tKquMdqFk0e1uH9Euhwn+1tuOWtLmARAvZj+43/MgnioLqbls1klgW
         g3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684703; x=1739289503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uB2kJTb8QdOsUK0L7YFlrm67ABkU6a2AEVF7OP8woU=;
        b=HbHb/N0KyAJ5sZN2PoMdkuzqt5/8Qqr4zACooXWybSCmRpIEhEYyAAF2a/7LEAH/rr
         17U81ML1prmmz1uASFlyq1l4wy02H5dD9ceBYETk/xMJI9xr+5N0YFW7iGcd2y+pcITm
         UPXxephEfKMLPyV4YRnHjjLWQCxk8TeaVQyAF2ig7Jb0gMLc7vNCfChUqtJjfQPqWPqd
         sBAUf0NTNRaXU79rJezkkg4Akox0cyB95fAVeKw2ZTCv00hmsEj1MkbWLkBrtwMpvO3t
         xgOqlf1UhB9UixqPLt8D5AI9vSLSw1Mhnnpxpl4cOsU4U6e01pl9HmH/DroNRuq/h0FQ
         8nqw==
X-Forwarded-Encrypted: i=1; AJvYcCVk2kj9fmEppnfrWHfmnFUI1xGAmXYP3CJiXOmJehRdewvhKSxxAI2jFum1h3MNtToCC4rc5Wk4EruQCJsytCY=@vger.kernel.org, AJvYcCXPP77TeW5E2r/B3qm0fnphEtfzdDk8vlomOEXM+nPU6VljzKp6j+V+6rceS4jVMKwJDxlaYoVbzwCGIiG4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9DgtyIwekALVeBxXrtTlg0TQI9VKkiZSxYzLIxJCkHpnswXYE
	i0zf2n3dFmW+iEGuIMVX97o88G6s99QYXgEbK+8dEpXKj47OSF92iKUWnSWjQQVeOtKCYFNN7ov
	XM3vIv/F3ZNEVetanbzt7JjypXSI=
X-Gm-Gg: ASbGncvYYduIQHFxsXq26pN+t3iv7XdXrvHDiner5kizQHhKLlNWlQjHHST4hqI4NGq
	XKdb9dJOTF45thRMulwWQULTuyIaHFuBvJHLn3aUwriRzlVQ562sC+QYWyFAsoeQ9/ffB6QY=
X-Google-Smtp-Source: AGHT+IHW9GxC/TcJGuLrCLjpmO/aQ4mpI8PFi9S7e+Fb+4RmuNwKDiXV6w+lylLH1atj4xsNf9lGehSKmuAJLEuRmBg=
X-Received: by 2002:a05:6402:50ca:b0:5dc:5e37:b3ab with SMTP id
 4fb4d7f45d1cf-5dc5efc1e31mr30790551a12.12.1738684702790; Tue, 04 Feb 2025
 07:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com> <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook>
In-Reply-To: <202502040717.FCEFDB7E0@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 16:58:10 +0100
X-Gm-Features: AWEUYZmY3UJTrZZwxs8Jm5FMnyNZZ4ZBtTxGT54CvHbzHL5s97u6pP-uEnCtnHA
Message-ID: <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
To: Kees Cook <kees@kernel.org>
Cc: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, akpm@linux-foundation.org, brauner@kernel.org, 
	gustavoars@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 04, 2025 at 12:38:30PM +0100, Mateusz Guzik wrote:
> > On Tue, Feb 4, 2025 at 10:46=E2=80=AFAM syzbot
> > <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git:/=
/git...
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1258aeb05=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D57ab43c27=
9fa614d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D48a99e426f2=
9859818c0
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1582572=
4580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1658aeb05=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92=
/disk-69b8923f.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vm=
linux-69b8923f.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd=
15/bzImage-69b8923f.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/7c2919=
610764/mount_0.gz
> > >
> > > The issue was bisected to:
> > >
> > > commit bae80473f7b0b25772619e7692019b1549d4a82c
> > > Author: Mateusz Guzik <mjguzik@gmail.com>
> > > Date:   Wed Nov 20 11:20:35 2024 +0000
> > >
> > >     ext4: use inode_set_cached_link()
> > >
> >
> > This looks like a case of a deliberately corrupted image.
> >
> > I added back a debug printk I used when writing the patch before. For
> > correct cases it reports:
> >
> > [   19.574861] __ext4_iget: inode ff18d9bec05977c8 [/etc/environment]
> > i_size 16 strlen 16
> > [   19.585987] __ext4_iget: inode ff18d9bed6f25c68
> > [/etc/alternatives/awk] i_size 21 strlen 21
> > [   19.590419] __ext4_iget: inode ff18d9bed6f24108 [/usr/bin/gawk]
> > i_size 13 strlen 13
> > [   19.592199] __ext4_iget: inode ff18d9bed6abeea8
> > [libassuan.so.0.8.5] i_size 18 strlen 18
> > [   19.593804] __ext4_iget: inode ff18d9bed6f29368
> > [libsigsegv.so.2.0.7] i_size 19 strlen 19
> >
> > etc.
> >
> > However, the bogus case is:
> > [   52.161476] __ext4_iget: inode ff18d9bed1cc2a38
> > [/tmp/syz-imagegen43743633/file0/file0] i_size 131109
> > strlen 37
> >
> > That is i_size is out of sync with strlen.
> >
> > Prior to my patch this happened to work because the copying was in
> > fact issuing strlen to find the size every time.
> >
> > Given this code in fs/ext4/inode.c:
> >   5008                 } else if (ext4_inode_is_fast_symlink(inode)) {
> >   5009                         inode->i_op =3D &ext4_fast_symlink_inode=
_operations;
> >   5010                         nd_terminate_link(ei->i_data, inode->i_s=
ize,
> >   5011                                 sizeof(ei->i_data) - 1);
> >
> > To me this looks like a pre-existing bug in ext4 which just happened
>
> This gets clamped to i_data size, though, so I don't see a bug. Is there
> still a code path where i_size is getting used? It looks like the buffer
> overflow was introduced with bae80473f7b0 ("ext4: use inode_set_cached_li=
nk()"),
> more details below...
>
> > to get exposed with:
> >
> >   5012                         inode_set_cached_link(inode, (char *)ei-=
>i_data,
> >   5013                                               inode->i_size);
>
> The sanity checker said:
> > usercopy: Kernel memory exposure attempt detected from SLUB object 'ext=
4_inode_cache' (offset 0, size 176)!
>
> The cache was created to make only the i_data field visible:
>
>         ext4_inode_cachep =3D kmem_cache_create_usercopy("ext4_inode_cach=
e",
>                                 sizeof(struct ext4_inode_info), 0,
>                                 SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>                                 offsetof(struct ext4_inode_info, i_data),
>                                 sizeof_field(struct ext4_inode_info, i_da=
ta),
>                                 init_once);
>
> which is 15 bytes, at offset 0:
>
> struct ext4_inode_info {
>         __le32  i_data[15];     /* unconverted */
>         __u32   i_dtime;
>
> So, yes, this seems like a buffer overflow caught by usercopy, where the
> bug was as described above. I don't think there was an existing flaw in
> ext4, though?
>

I don't follow. Are you claiming the cached symlinks can only be up to
15 sizeof(i_data) in size?

In the long above you can see lengths bigger than that.

I had the vm still running, dmesg shows some more printks with lengths
above that:
[  695.648078] __ext4_iget: inode ff18d9bed33c3c78
[../Pacific/Pago_Pago] i_size 20 strlen 20
[  695.650647] __ext4_iget: inode ff18d9bed33c60f8
[../America/Los_Angeles] i_size 22 strlen 22
[  695.653160] __ext4_iget: inode ff18d9bec8be8128 [../America/Denver]
i_size 17 strlen 17
[  695.656716] __ext4_iget: inode ff18d9bed325dc68
[../America/Detroit] i_size 18 strlen 18
[  695.660450] __ext4_iget: inode ff18d9bed325ca28
[../America/Indiana/Knox] i_size 23 strlen 23
[  695.664270] __ext4_iget: inode ff18d9bed325c108
[../Pacific/Honolulu] i_size 19 strlen 19
[  695.666569] __ext4_iget: inode ff18d9bed325aec8
[../America/Indiana/Indianapolis] i_size 31 strlen 31

Note with and without the patch there is copy_to_user from that area
taking place.

Regardless, as you can see all the symlinks so far have i_size lining
up with strlen.

The only case which does not is the (presumably intentionally
corrupted) fs image from syzbot. Sounds like the link should be
rejected by ext4 instead?

Again I can do that strlen() call, but it seems like papering over the
problem for me.

--=20
Mateusz Guzik <mjguzik gmail.com>
