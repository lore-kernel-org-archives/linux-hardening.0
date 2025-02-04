Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22025A62C;
	Tue,  4 Feb 2025 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704345; cv=none; b=YGqvCp9/c6wzZXD/JHdM8kOnHeNO8cHjwV+trOfiTmozyigaf6TmUSsHGqMkkwtDCHcuzqgjvQOBgIFj+ZbdYp+VsgQKXnqggd1mX7vKaMWDjJjGgdZnFscmhle13plekd7RD62t4+mqitbcCRrLqrEL7qUtIpmzGTQLOSHwt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704345; c=relaxed/simple;
	bh=KkuJStOFGP+DhRKY5bNAaUqJbu7eJw/FdsyTkzYvyRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/XfhXn8ovMjwo8iWtNCDBz1t8bPwxAQ+YFTAgjhLBdFOerwjd9P5ywvcDkB4881OkC+m9w5gUqTDxZMDu75HUzYpZQv3G9IC+3E5zxuqsKGpF+xstXjv+TMRBKrrZTwRQ+VPfyvDaucRmwtFFvhWLSlHgZg2XaXDgqJsjhopZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V64ELIeD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V64ELIeD"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so13027917a12.2;
        Tue, 04 Feb 2025 13:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738704341; x=1739309141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4C3nF0MrFU3lYanCxKKbK2G+JW9NeWKWWVNPsiXZNQ=;
        b=V64ELIeDFlxpvi32zxfegIRQJf9bhrGFc3fmdbHW7MAP589qBFRbgv1l/4x+iiQgGW
         8wJJFa8DlSejMbHFwuOErBjOn8tfHbIaAzxLhamb2eVOoXHfvDizwsRZx8QDqMHok/Af
         +9mjvLXzAClhVgB+aJ3iFdIjcDJYwXY7cqVwLl60Hi933zq1ZUGX0FSBlkeGU7EhA4Z7
         +wKOuSXcPXtQQrEATQ328WGP4APVeKnbgQTKJvPk1HHkphDHer/5wr1b59MNyjKulAFg
         oKlq9oGRq6JuwRkrZtz14VooQR124k5BKsDKJgw6REkbQarvgDDbjSnMfhZOnWx9UjV9
         6yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704341; x=1739309141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4C3nF0MrFU3lYanCxKKbK2G+JW9NeWKWWVNPsiXZNQ=;
        b=XNKpWMjIdg4hlermFeNtHiJpDZI65ep/KhF8Zb714ZQp/yZNfTgsX/YCg8mPwTvxFN
         tUM4DRQi+o/KOqDKTZF0JRsbLuDZJSqX4zA9Ucm2fH6gpBRevWeiqCswSoiXiw683dJH
         w31UrRwgeodEi9cKnAKWdeqqWdHqQRrQuOvG+DzmJWKEhTK4uftnc57ZyHSlrLbxfY20
         oIR5QJzLnYnjtsetKeLO/wKo9Jh0aBegA6+UOX4jyRSWNziqh4e3N0NigbpwT7IUgcJk
         KOhfPcL5M9EHjpjnIGhJ1JKxpvj+YRsxsMv4kynhBMAOPaS+6J35Lo1OsFXFw8ie5vie
         dwHw==
X-Forwarded-Encrypted: i=1; AJvYcCVNwFc5GXwuqoXE3bKx249fU4n90Cf0Nq15pPCWtYz+D9E4dHUzz1GO880Xr82hDI2WzFdWWjP5ugRFOPuy8Dk=@vger.kernel.org, AJvYcCVht81s0xn0mz62pWvm8O+xAqUq4pMTwB62MypH1+IscXuJoegpa+wA3sfaAYRJvp0j+Ci2SZGGYe6vv2Xr@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcPuBiIDsOLCMkfXFIDlaq9QNKCeaFbPRBTp5oCr85cnm5dgE
	9NTLbvSMyglpqy3rP0VnRYi1zvFvjZGiY6XrDB/1wTMnkLycfvEUv1MIKLjPL1IUQz0AAXIhuMh
	f7FvLSYARqZEiU9Ftj5JeCWOnfdA=
X-Gm-Gg: ASbGnct7YK9PTO32P4kVnvlC8MrwI46+6pY6A+NeUY/8vIiO8p7IWxpUq5f1jGUrZYt
	lB/CAkACXYY4unO0qXjvdgYjE10XrBAOcmku46U9ysfzP0zv/olI3FDwIeFPKPokL2kflYMA=
X-Google-Smtp-Source: AGHT+IGjcSWjs+ThZeODFo1Ch/yAVmyGtwLMyZHY93carg6mxOuz8K/lwuEqDLo0g3BJ/62afzxS2kQCol8JaUeguSE=
X-Received: by 2002:a05:6402:358d:b0:5dc:cc02:5d25 with SMTP id
 4fb4d7f45d1cf-5dcdb73336emr654488a12.11.1738704341310; Tue, 04 Feb 2025
 13:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com> <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook> <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
 <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com>
 <20250204203059.GA909029@mit.edu> <CAGudoHFvLiCnCkAQN82qhdqmy0P2=Ywtnwqkc3KOc3s3hUQX8g@mail.gmail.com>
In-Reply-To: <CAGudoHFvLiCnCkAQN82qhdqmy0P2=Ywtnwqkc3KOc3s3hUQX8g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 22:25:29 +0100
X-Gm-Features: AWEUYZn5Bnu3knhWyzIOw0Z5zwfvbIPBa4gVp-XE170mO4LdzTpwkbg3B8Bab6M
Message-ID: <CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <kees@kernel.org>, 
	syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:48=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Tue, Feb 4, 2025 at 9:31=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrot=
e:
> >
> > On Tue, Feb 04, 2025 at 05:49:48PM +0100, Mateusz Guzik wrote:
> > > I'm going to restate: the original behavior can be restored by
> > > replacing i_size usage with a strlen call. However, as is I have no
> > > basis to think that the disparity between the two is legitimate. If a=
n
> > > ext4 person (Ted cc'ed) tells me the disparity can legally happen and
> > > is the expected way, I'm going to patch it up no problem.
> >
> > There are two kinds of symlinks in ext4.  "Fast symlinks", where the
> > symlink target can fit in i_block[].  And normal, sometimes called
> > "slow" symlinks, where i_block[] contains a pointer to data block
> > (either i_blocks[0] for a traditional inode, or the root of an extent
> > tree that will fit in i_block[] if EXTENTS_FL is set).  In the case
> > of a fast symlink, the maximum size of the file system is
> > sizeof(i_block[])-1.  For a normal/slow symlink, the maximum size is
> > super->s_blocksize.
> >
> > We determine whether a symlink is "fast" or not by checking whether
> > i_size is less than sizeof(i_blocks[]).  In other words. if i_size
> > less than 60 (and it's not an encrypted inode), it's a fast symlink
> > and we set i_link to point to the i_block array.  From __ext4_iget()
> > in fs/ext4/inode.c:
> >
> >                 if (IS_ENCRYPTED(inode)) {
> >                         inode->i_op =3D &ext4_encrypted_symlink_inode_o=
perations;
> >                 } else if (ext4_inode_is_fast_symlink(inode)) {
> >                         inode->i_link =3D (char *)ei->i_data;
> >                         inode->i_op =3D &ext4_fast_symlink_inode_operat=
ions;
> >                         nd_terminate_link(ei->i_data, inode->i_size,
> >                                 sizeof(ei->i_data) - 1);
> >                 } else {
> >                         inode->i_op =3D &ext4_symlink_inode_operations;
> >                 }
> >
> >
> > The call to nd_terminate_link() guarantees that inode->i_link is
> > NUL-terminated, although the on-disk formatshould have already been
> > NUL-terminated when the symlink is set.
> >
>
> It is nul-terminated, but inode->i_size does not line up with it -- as
> in the inode size pulled from the disk image is different than what
> strlen would suggest.
>
> My question is if that's legitimate, I'm guessing not. If not, then
> ext4 should complain about it.
>
> On stock kernel this happens to work because strlen finds the "right" siz=
e.
>

So it occurred to me to check what fsck thinks about it.

I ran it twice in a row, it *removed* the problematic symlink.
e2fsck 1.47.0 (5-Feb-2023)
One or more block group descriptor checksums are invalid.  Fix<y>? yes
Group descriptor 0 checksum is 0xd7c5, should be 0xa2fe.  FIXED.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Symlink /file0/file1 (inode #14) is invalid.
Clear<y>? yes
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
[ERROR] ../../../../lib/support/quotaio_tree.c:546:check_reference:
Illegal reference (4294967295 >=3D 6) in user quota file
Update quota info for quota type 0<y>? yes
[QUOTA WARNING] Usage inconsistent for ID 4294967295:actual (0, 0) !=3D
expected (458752, 8)
[QUOTA WARNING] Usage inconsistent for ID 0:actual (458752, 8) !=3D
expected (0, 0)
[ERROR] ../../../../lib/support/quotaio_tree.c:546:check_reference:
Illegal reference (256 >=3D 6) in group quota file
Update quota info for quota type 1<y>? yes

syzkaller: ***** FILE SYSTEM WAS MODIFIED *****
syzkaller: 16/32 files (0.0% non-contiguous), 160/512 blocks

So I stand by my assessment that the symlink fetching code should
check for the problem of size vs strlen disparity.

> > Also note that there really is no point to caching inodes where
> > inode->i_link is not a NUL pointer, since in those cases we never call
> > file system's get_link() function; the VFS will just fetch it straight
> > from i_link.  And in those cases, it's because it's a "fast symlink"
> > (many file systems have this concept; not just ext[234]) and the
> > symlink target was read in as part of the on-disk inode, and so there
> > is no separate disk block read read the symlink.  And so if you are
> > attempting to cache symlinks where inode->i_link is non-NULL, you're
> > just wasting a small amount of memory, and wasting the CPU time to do
> > the strcpy.
> >
>
> My code does not allocate any extra memory or do any extra copies.
>
> The code prior to my change would grab i_link, strlen on it and pass
> that to copy_to_user every single time readlink is issued.
>
> My code stores the size in the inode (unioned with a field not used
> for symlinks, so no again no increase in memory usage) so that the
> strlen call can be avoided. Past that it's the same thing.
>
> --
> Mateusz Guzik <mjguzik gmail.com>



--=20
Mateusz Guzik <mjguzik gmail.com>
