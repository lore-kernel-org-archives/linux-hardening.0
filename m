Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C916206F16;
	Tue,  4 Feb 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702118; cv=none; b=k7jRFEchVYyYxc0eIPdePTONlhff+QuYMwjK3XZeEvvDvd91mquuQYyLY3JEQfFEpgbeOobzPEOahiwj6kd6M/jt3+rvTVK5tuKofCFpUmKXCbuG3w1Cpk4IkzMIBGMO+j/IDUMR8iqnBDg7/rtpRrzAw0N8Iy2QAFax+GafOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702118; c=relaxed/simple;
	bh=9pwapduGHyrvDVXYuWRes6xwy0ReLAV+i0SRSShoy64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfR2brY1WnHPJpGUwXUoiDg6+ZukVVw3XopGMWj914Lqinz0/faYDn3RClr9CXZZSWyuXCMYYu4S4/BHfwXKDnrdDHn2Z2fkbW/diHG+GTCFUAAu1IqEE//AGj5o94z3y8GEqJrZhjxcm3h7w3yZQEHCVioc8Ax97UO4Vj8T6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsuU70Xn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsuU70Xn"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaedd529ba1so815746966b.1;
        Tue, 04 Feb 2025 12:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738702115; x=1739306915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB+b5/GLNJBneFA5sTPfeIuegF7/CdQflpntzTg1wUc=;
        b=FsuU70Xnu1cgIYLMsYz28g2b26LwtYROQRe0U3HRenUGToVQPw2qLGIV9eGhP76Y7S
         eSXLO5tUZ9x7Wyk08OC6sRU554aR3CrJZ7n/zsUz5ZIwgHcygqVewctMiRzMRWrsiHz9
         p+c6jh5/LKucgzdDj/6Sv1RZaTRInv3I59chDtnqK0xxQzfggSKgXmmgAOf5tQRh0Nfr
         lzXDvsRZsx07zpN+wFwGYnrpXmMWZjmENDxzaAQ4vL3rNz/1WC6QNEFIcCFFKBhZ2f/0
         GtZAKBY++wKP+38Pr2Q46QfGL87SUOF0kzpMYIsA+yImq4pjsSvmYf8unVW+LcNkMqtn
         lx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738702115; x=1739306915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UB+b5/GLNJBneFA5sTPfeIuegF7/CdQflpntzTg1wUc=;
        b=hfT4UrFPIZEJj0GyOqn3KkFHLoebyIVrkf7rW6bYsCgqMelwp+stU305P6OgOFGsYX
         krFLnRhVnLGo2Iy7CFpdIKXjLMWPfWNGUHS9D9dVaZfImZPVGcyd9pmnHfauLze089rb
         1zRkQRCrunsEor27FbDsUunybfYY2B7et1DbDtpWwHzjTtxokx7VGV8vf3gvD/z2KTrO
         x4EI4AhRGnDGM4o3fTc7A+W+GYOm84iNccx2R5veoz0Z1qtEsbxjVEg4aLOspwiBqzpD
         9mEtXXbqUMDZlyRLsfW2znNviDZ+cAWMBwgfDgvGfx2xaqm9gPmIeilKAtOhoy/bOvhw
         0kow==
X-Forwarded-Encrypted: i=1; AJvYcCVjbN8kxzSWCXDBeCPfQxvhRQyAw0kwnADWmdotn6DKcps6bDn4WyttYPqaPPk3qoKWAgoxFZJhk1o/tSnmf58=@vger.kernel.org, AJvYcCXKxuACxvuWy+yRpwZoj3duurVJf7/FDSN7MR9Y8Ho8W9OsNPw/NtNYdvZ58eY+HDZnLQkC5yWXd02QmYJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVCw0+SfqYXUDUIl/LB/P4qKApmRsJi3qmZWyJscqtbrrDTzY
	gus06e6fcytxUPqrzGpP8p3CiDI2n78f+AzZnZrjqJWzd/hPX8jVagR5wc2p2wwe51CzEDmkoDJ
	60oZqds1Q/cHflfcfjIKm03NOnTw=
X-Gm-Gg: ASbGncsSbjXxlkep+rJO5UVBQUbMxc1v9oEqvP0oCXHJF+5F3mWOCCieGWUrbWiV//e
	eO+4500LU82BUCUJw1Gjkt3t8z3TCBWM5KvWyH95O+m16zWnRs9YeVIdbTvMmaOzoh7vJLIE=
X-Google-Smtp-Source: AGHT+IHvAbD26S2+1hOEKdqIS8Zalo8h8j8u/5qXBrcKts7qsx9/xmkOOjKUAnQ5Ch9x4VJq/vXmdsmwAjw6JAosUyg=
X-Received: by 2002:a05:6402:34c5:b0:5dc:d9cb:64fc with SMTP id
 4fb4d7f45d1cf-5dcdb72d925mr1188382a12.19.1738702114410; Tue, 04 Feb 2025
 12:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com> <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook> <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
 <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com> <20250204203059.GA909029@mit.edu>
In-Reply-To: <20250204203059.GA909029@mit.edu>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 21:48:22 +0100
X-Gm-Features: AWEUYZkNzkwghVnO_pWEtGkamlUcqUiswAmdummI6fCkRwHW3xW4dHRdUed_0s8
Message-ID: <CAGudoHFvLiCnCkAQN82qhdqmy0P2=Ywtnwqkc3KOc3s3hUQX8g@mail.gmail.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <kees@kernel.org>, 
	syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:31=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Feb 04, 2025 at 05:49:48PM +0100, Mateusz Guzik wrote:
> > I'm going to restate: the original behavior can be restored by
> > replacing i_size usage with a strlen call. However, as is I have no
> > basis to think that the disparity between the two is legitimate. If an
> > ext4 person (Ted cc'ed) tells me the disparity can legally happen and
> > is the expected way, I'm going to patch it up no problem.
>
> There are two kinds of symlinks in ext4.  "Fast symlinks", where the
> symlink target can fit in i_block[].  And normal, sometimes called
> "slow" symlinks, where i_block[] contains a pointer to data block
> (either i_blocks[0] for a traditional inode, or the root of an extent
> tree that will fit in i_block[] if EXTENTS_FL is set).  In the case
> of a fast symlink, the maximum size of the file system is
> sizeof(i_block[])-1.  For a normal/slow symlink, the maximum size is
> super->s_blocksize.
>
> We determine whether a symlink is "fast" or not by checking whether
> i_size is less than sizeof(i_blocks[]).  In other words. if i_size
> less than 60 (and it's not an encrypted inode), it's a fast symlink
> and we set i_link to point to the i_block array.  From __ext4_iget()
> in fs/ext4/inode.c:
>
>                 if (IS_ENCRYPTED(inode)) {
>                         inode->i_op =3D &ext4_encrypted_symlink_inode_ope=
rations;
>                 } else if (ext4_inode_is_fast_symlink(inode)) {
>                         inode->i_link =3D (char *)ei->i_data;
>                         inode->i_op =3D &ext4_fast_symlink_inode_operatio=
ns;
>                         nd_terminate_link(ei->i_data, inode->i_size,
>                                 sizeof(ei->i_data) - 1);
>                 } else {
>                         inode->i_op =3D &ext4_symlink_inode_operations;
>                 }
>
>
> The call to nd_terminate_link() guarantees that inode->i_link is
> NUL-terminated, although the on-disk formatshould have already been
> NUL-terminated when the symlink is set.
>

It is nul-terminated, but inode->i_size does not line up with it -- as
in the inode size pulled from the disk image is different than what
strlen would suggest.

My question is if that's legitimate, I'm guessing not. If not, then
ext4 should complain about it.

On stock kernel this happens to work because strlen finds the "right" size.

> Also note that there really is no point to caching inodes where
> inode->i_link is not a NUL pointer, since in those cases we never call
> file system's get_link() function; the VFS will just fetch it straight
> from i_link.  And in those cases, it's because it's a "fast symlink"
> (many file systems have this concept; not just ext[234]) and the
> symlink target was read in as part of the on-disk inode, and so there
> is no separate disk block read read the symlink.  And so if you are
> attempting to cache symlinks where inode->i_link is non-NULL, you're
> just wasting a small amount of memory, and wasting the CPU time to do
> the strcpy.
>

My code does not allocate any extra memory or do any extra copies.

The code prior to my change would grab i_link, strlen on it and pass
that to copy_to_user every single time readlink is issued.

My code stores the size in the inode (unioned with a field not used
for symlinks, so no again no increase in memory usage) so that the
strlen call can be avoided. Past that it's the same thing.

--=20
Mateusz Guzik <mjguzik gmail.com>
