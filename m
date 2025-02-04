Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450986324;
	Tue,  4 Feb 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687805; cv=none; b=pFNFUZuWzLq+1kLdLnFpbrQomydPYWl/s9I47aCwryUkzumZRK/fTOxvWTh3YLqXESRGDo9GO+Q3yaBnsmsM/pNbLLPKIXA0kp/+pAP6vZmSrRPnhe2QDTnk0gnVxhEf5gKPkt1Lkk12WmUFGQZHhmh747BtQ7ukPPfsHFZug6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687805; c=relaxed/simple;
	bh=zF0IKm/pUXqYEmnDw2+7sN8iGRMe7pzKW6fAJE+IkpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTyQ/sUV4YG9b5ip8r0TXySATqm+ScnYgigUNyArmxto2JTLMfYSzEp3YYA81rFxMnuQiTNoZYSDbX1cLynUe13VKrbRNaxtn/UkgkNQf9D4arSVhEDUaBygNLLjkdYzfXcNegG3pncrsK9677iFKDImjgIXTDi5iI3kpN6rY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwG7ly6M; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwG7ly6M"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7254672a12.3;
        Tue, 04 Feb 2025 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738687801; x=1739292601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/higoSSduy/KO2yVDFknDgAYJkI4wtcMS+4qzTFpIHw=;
        b=cwG7ly6M9KOZ4i7CX5910+V4zmwSqu7B05u7NEk5R2+Ciml1X2Fil9C4OIqcYIdVqa
         ycVY0Yp6aleorOvvR9qvxEFj2ZLh02V3X6BHKiSbXLslIsXp6sH7WN/G4u4AIOBKZwU4
         CBnQOu8JyqfIVVfBZcJ0gNERAJIcYnNK+v4LV13BGbM+tK3SxUu05KZJoJyAnJUcB8Oc
         yczPS7stg72X7WXDzTMoY4R9HdAfqs8KnK7e+FPgRElQ12AOuT7OFwvXqpiS6l3qzZ9O
         JgF2gk4L35hljcnd8VndLOy4UYJE6LZZNNOhCU4QKbyBMYTcMi/p6rECdTCCjasCGIVn
         RwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687801; x=1739292601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/higoSSduy/KO2yVDFknDgAYJkI4wtcMS+4qzTFpIHw=;
        b=akO21XDclYcHPQvTZbe20cm0K8dwAT37Www9eKdeIOV+LFCGf5ChVTGLzSCVWlk3Es
         4wUTvJC61tSHrVdXPewd/BqIbKjVjUD8MYFZB82wVLc4LTA7cTaCJ5gkMFaRyMfIZjr8
         k8W8drCS0Wdv6jxdE26mo6ahg5NhYDZtiEuCoNheMQIR2U52jpzoGnwZCY8u+91Wwi/n
         HL/Hkr5qg0vn9i4wumCOOFOkV4V+nDlCvizmEK3fKlASFgVM1hnwwBefaJLmFg03NbzK
         LbIOw8prJs1DBy6IkEUyPutjqlkQxp0zNOOEVDuIwhBRlUN+r5gnJF1OrOgHPrsyrLkk
         AxSg==
X-Forwarded-Encrypted: i=1; AJvYcCUpaoKD5jutyXvy1o5etJC+UK0fpspKbC71iQPfOD2ejOJwbOLDBJ250FLxt9clW5eWN2flSGOprMY4G/D4@vger.kernel.org, AJvYcCUpqt3+hjKap/65rRncUu90b+Pi2xevvJHj8bhqQcMdMiAEUZEs8A1pswt2j+WQbjkyjrvXCyWfKq+NguL/sgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOv+oHSNbcmDVuYzL0UtDJFN4TOuSNl3cUo3HAU/onP5mNVAO
	w9EZT52WFM/3SWUbgfzocVFdi38Mm9ZhGtHRYUBlItF0ecHdddci647Hel4VrXadGaL0u52clnc
	cfmEi+hiZeeNhxXlT+B+TylYSEbE=
X-Gm-Gg: ASbGncuweNihRXi0LS5PBYdk5X+00XJHOBFxE4RQoNY9q0QVqEXysQz4wLWoGZTWWjT
	WALGa2p6X4dULVPNWnZXKGAnSzIJ0MqHAMpAVc8s/z8CHQXXmCEihHPNSpeCp+0HGisunwvo=
X-Google-Smtp-Source: AGHT+IHfxdQG2tJlCpw/8xpw+d7GjY4QltazgqxiSu1xU4R6shZ98eYPrJEgfxG48JgSqPoUwLICbUz62hDYbQjkmeI=
X-Received: by 2002:a05:6402:26cc:b0:5dc:c869:da53 with SMTP id
 4fb4d7f45d1cf-5dcc869dd38mr3157635a12.31.1738687800777; Tue, 04 Feb 2025
 08:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com> <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook> <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
In-Reply-To: <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 17:49:48 +0100
X-Gm-Features: AWEUYZnJ0U7VzGUSpHXrBnGDNIKmZNbTo6AYkphiwPn1O-6LS8WWCVuo0Q9swnI
Message-ID: <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
To: Kees Cook <kees@kernel.org>
Cc: syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, akpm@linux-foundation.org, brauner@kernel.org, 
	gustavoars@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:58=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Tue, Feb 4, 2025 at 4:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 12:38:30PM +0100, Mateusz Guzik wrote:
> > > On Tue, Feb 4, 2025 at 10:46=E2=80=AFAM syzbot
> > > <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git=
://git...
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1258aeb=
0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D57ab43c=
279fa614d
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D48a99e426=
f29859818c0
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15825=
724580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1658aeb=
0580000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e=
92/disk-69b8923f.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/=
vmlinux-69b8923f.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2=
bd15/bzImage-69b8923f.xz
> > > > mounted in repro: https://storage.googleapis.com/syzbot-assets/7c29=
19610764/mount_0.gz
> > > >
> > > > The issue was bisected to:
> > > >
> > > > commit bae80473f7b0b25772619e7692019b1549d4a82c
> > > > Author: Mateusz Guzik <mjguzik@gmail.com>
> > > > Date:   Wed Nov 20 11:20:35 2024 +0000
> > > >
> > > >     ext4: use inode_set_cached_link()
> > > >
> > >
> > > This looks like a case of a deliberately corrupted image.
> > >
> > > I added back a debug printk I used when writing the patch before. For
> > > correct cases it reports:
> > >
> > > [   19.574861] __ext4_iget: inode ff18d9bec05977c8 [/etc/environment]
> > > i_size 16 strlen 16
> > > [   19.585987] __ext4_iget: inode ff18d9bed6f25c68
> > > [/etc/alternatives/awk] i_size 21 strlen 21
> > > [   19.590419] __ext4_iget: inode ff18d9bed6f24108 [/usr/bin/gawk]
> > > i_size 13 strlen 13
> > > [   19.592199] __ext4_iget: inode ff18d9bed6abeea8
> > > [libassuan.so.0.8.5] i_size 18 strlen 18
> > > [   19.593804] __ext4_iget: inode ff18d9bed6f29368
> > > [libsigsegv.so.2.0.7] i_size 19 strlen 19
> > >
> > > etc.
> > >
> > > However, the bogus case is:
> > > [   52.161476] __ext4_iget: inode ff18d9bed1cc2a38
> > > [/tmp/syz-imagegen43743633/file0/file0] i_size 131109
> > > strlen 37
> > >
> > > That is i_size is out of sync with strlen.
> > >
> > > Prior to my patch this happened to work because the copying was in
> > > fact issuing strlen to find the size every time.
> > >
> > > Given this code in fs/ext4/inode.c:
> > >   5008                 } else if (ext4_inode_is_fast_symlink(inode)) =
{
> > >   5009                         inode->i_op =3D &ext4_fast_symlink_ino=
de_operations;
> > >   5010                         nd_terminate_link(ei->i_data, inode->i=
_size,
> > >   5011                                 sizeof(ei->i_data) - 1);
> > >
> > > To me this looks like a pre-existing bug in ext4 which just happened
> >
> > This gets clamped to i_data size, though, so I don't see a bug. Is ther=
e
> > still a code path where i_size is getting used? It looks like the buffe=
r
> > overflow was introduced with bae80473f7b0 ("ext4: use inode_set_cached_=
link()"),
> > more details below...
> >
> > > to get exposed with:
> > >
> > >   5012                         inode_set_cached_link(inode, (char *)e=
i->i_data,
> > >   5013                                               inode->i_size);
> >
> > The sanity checker said:
> > > usercopy: Kernel memory exposure attempt detected from SLUB object 'e=
xt4_inode_cache' (offset 0, size 176)!
> >
> > The cache was created to make only the i_data field visible:
> >
> >         ext4_inode_cachep =3D kmem_cache_create_usercopy("ext4_inode_ca=
che",
> >                                 sizeof(struct ext4_inode_info), 0,
> >                                 SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
> >                                 offsetof(struct ext4_inode_info, i_data=
),
> >                                 sizeof_field(struct ext4_inode_info, i_=
data),
> >                                 init_once);
> >
> > which is 15 bytes, at offset 0:
> >
> > struct ext4_inode_info {
> >         __le32  i_data[15];     /* unconverted */
> >         __u32   i_dtime;
> >
> > So, yes, this seems like a buffer overflow caught by usercopy, where th=
e
> > bug was as described above. I don't think there was an existing flaw in
> > ext4, though?
> >
>
> I don't follow. Are you claiming the cached symlinks can only be up to
> 15 sizeof(i_data) in size?
>
> In the long above you can see lengths bigger than that.
>
> I had the vm still running, dmesg shows some more printks with lengths
> above that:
> [  695.648078] __ext4_iget: inode ff18d9bed33c3c78
> [../Pacific/Pago_Pago] i_size 20 strlen 20
> [  695.650647] __ext4_iget: inode ff18d9bed33c60f8
> [../America/Los_Angeles] i_size 22 strlen 22
> [  695.653160] __ext4_iget: inode ff18d9bec8be8128 [../America/Denver]
> i_size 17 strlen 17
> [  695.656716] __ext4_iget: inode ff18d9bed325dc68
> [../America/Detroit] i_size 18 strlen 18
> [  695.660450] __ext4_iget: inode ff18d9bed325ca28
> [../America/Indiana/Knox] i_size 23 strlen 23
> [  695.664270] __ext4_iget: inode ff18d9bed325c108
> [../Pacific/Honolulu] i_size 19 strlen 19
> [  695.666569] __ext4_iget: inode ff18d9bed325aec8
> [../America/Indiana/Indianapolis] i_size 31 strlen 31
>
> Note with and without the patch there is copy_to_user from that area
> taking place.
>
> Regardless, as you can see all the symlinks so far have i_size lining
> up with strlen.
>
> The only case which does not is the (presumably intentionally
> corrupted) fs image from syzbot. Sounds like the link should be
> rejected by ext4 instead?
>
> Again I can do that strlen() call, but it seems like papering over the
> problem for me.
>

I'm going to restate: the original behavior can be restored by
replacing i_size usage with a strlen call. However, as is I have no
basis to think that the disparity between the two is legitimate. If an
ext4 person (Ted cc'ed) tells me the disparity can legally happen and
is the expected way, I'm going to patch it up no problem.

--=20
Mateusz Guzik <mjguzik gmail.com>
