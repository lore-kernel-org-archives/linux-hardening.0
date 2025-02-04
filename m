Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAA203710
	for <linux-hardening@vger.kernel.org>; Tue,  4 Feb 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738701091; cv=none; b=a5MRkkVSYVHsWFWqflEU7EIP9CXR12sAsFeDmRHdl32prIryxmXs4ms+TaNWnPdn+s6ebE2+rWIa0V5MzRU76LkufVuZL93WAvpdxZYxSOXTjYO3RqUdiq+HyBTenflxtiMDaQSOQIoiAGX8PNE+wybl5PKTNJD9NorZCowC74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738701091; c=relaxed/simple;
	bh=xSeq+Rgde/bKmuvO32XTPgXpmSV5DtEQ08hyIbEzvr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUDNSFCE8Q1rnndlqE99W+6K3rgtKnhu6NedP+dGEQsJEWhSRpOIU0rZ0O55rVnLT4SK2vKyBNXhW7yhvKjnj0XQ7+tFD4FsTyAkLrL0jDUOEqpjnLm+POyNOGps0rKKlg44yhGyVJC+jktgPG8T6++75AZ5JRG8RTi6zy/BYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EPsNDNQS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EPsNDNQS"
Received: from cwcc.thunk.org (pool-173-48-123-53.bstnma.fios.verizon.net [173.48.123.53])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 514KUxif000752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 15:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738701062; bh=4/0vnwTAY+3yDq4nuhuONLhdWsKfo0JI/NdVKfIt3iI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EPsNDNQSpXLZz8ui9ziG85f/tffGkISryc90YUNJwmpH5Gh0YL80QN+SDMcS8gqQT
	 VmnhJPfB0qa+UAxBbV11oKWHa67+YrQ2a6eMQqjVavJ6Ahq66LzuTkHIZwZITEJYic
	 NB/DP3LJRXWs0qxDnqf/jj/0fiQDb1OPRJ7Mzn8NtwQwERCGvatBnEmHEjFMUjyYTK
	 ygzjFBc74cEXHq0G+6Vphqa7bYRFTkEw7mSChRzdQKJ4n+Gn9FRmwMCzfpnYH2ffrQ
	 3ntPq6eScADZXWseBOgu0JELBBaOvRA7WsSbH2Q4ryDxVGbuBtOhSAuRKMu6ZRW+Fc
	 CvpjZSo21uqwg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 88EB115C013F; Tue, 04 Feb 2025 15:30:59 -0500 (EST)
Date: Tue, 4 Feb 2025 15:30:59 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
        syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <20250204203059.GA909029@mit.edu>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
 <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook>
 <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
 <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com>

On Tue, Feb 04, 2025 at 05:49:48PM +0100, Mateusz Guzik wrote:
> I'm going to restate: the original behavior can be restored by
> replacing i_size usage with a strlen call. However, as is I have no
> basis to think that the disparity between the two is legitimate. If an
> ext4 person (Ted cc'ed) tells me the disparity can legally happen and
> is the expected way, I'm going to patch it up no problem.

There are two kinds of symlinks in ext4.  "Fast symlinks", where the
symlink target can fit in i_block[].  And normal, sometimes called
"slow" symlinks, where i_block[] contains a pointer to data block
(either i_blocks[0] for a traditional inode, or the root of an extent
tree that will fit in i_block[] if EXTENTS_FL is set).  In the case
of a fast symlink, the maximum size of the file system is
sizeof(i_block[])-1.  For a normal/slow symlink, the maximum size is
super->s_blocksize.

We determine whether a symlink is "fast" or not by checking whether
i_size is less than sizeof(i_blocks[]).  In other words. if i_size
less than 60 (and it's not an encrypted inode), it's a fast symlink
and we set i_link to point to the i_block array.  From __ext4_iget()
in fs/ext4/inode.c:

		if (IS_ENCRYPTED(inode)) {
			inode->i_op = &ext4_encrypted_symlink_inode_operations;
		} else if (ext4_inode_is_fast_symlink(inode)) {
			inode->i_link = (char *)ei->i_data;
			inode->i_op = &ext4_fast_symlink_inode_operations;
			nd_terminate_link(ei->i_data, inode->i_size,
				sizeof(ei->i_data) - 1);
		} else {
			inode->i_op = &ext4_symlink_inode_operations;
		}


The call to nd_terminate_link() guarantees that inode->i_link is
NUL-terminated, although the on-disk formatshould have already been
NUL-terminated when the symlink is set.

Also note that there really is no point to caching inodes where
inode->i_link is not a NUL pointer, since in those cases we never call
file system's get_link() function; the VFS will just fetch it straight
from i_link.  And in those cases, it's because it's a "fast symlink"
(many file systems have this concept; not just ext[234]) and the
symlink target was read in as part of the on-disk inode, and so there
is no separate disk block read read the symlink.  And so if you are
attempting to cache symlinks where inode->i_link is non-NULL, you're
just wasting a small amount of memory, and wasting the CPU time to do
the strcpy.

It's also true that the vast majority of symlink targets are less than
60 bytes, which is why I was surprised that your symlink caching was
atually making a difference or many systems.  I guess if we have lots
of unicode file names with characters like ❤ and ❤️ and symlinks to
these files, you might have a bunch of slow symlinks.  But in the case
where you have symlinks like:

0 lrwxrwxrwx 1 root root 7 Dec 19  2020 /bin -> usr/bin/

Symlink caching won't do any good.

Cheers,

						- Ted
