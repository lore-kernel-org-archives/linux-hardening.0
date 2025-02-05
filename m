Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFF21D593
	for <linux-hardening@vger.kernel.org>; Wed,  5 Feb 2025 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733235; cv=none; b=RycH/iQN5ikXX+cucHuKRXfCGb1b/VcAuTck7P02Fhh8pFSyuTei7KGP5uYd0VEXWhGUbX9QTo0UiOoKUN+Rk5i6oqvUJz2Wkw/rIHNwyizwh+iNs0Vz+o2VtyxvxrZufU8YK/yIB7/+w+5ACinmMOtwrYkVZDvOpHPsv7/Ft/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733235; c=relaxed/simple;
	bh=7i9TcZBaYUs67CrDLuUfMTKEh1/RCoSDlZMEKLVcrh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPGlQ1gHRHJsuBNWrWGw47IlSmPrJxy+EptVGlkjpMiaAHHHeYUbpKw2DNVA/e/k4DE/pwHnN2dupfl6r9w/o7DUVJfDmb0BNIvcT2aaeRNyHXJgcY/mL8H8AGNjcSsmPXFK7/00iLbs4PkhfZ1MXaP1w3lbzpcb0VRx+27w4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KxEl+0yI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KxEl+0yI"
Received: from cwcc.thunk.org (pool-173-48-123-53.bstnma.fios.verizon.net [173.48.123.53])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5155QqfJ005305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 00:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738733215; bh=jFA1fICSDn3rgcW1sFZLN4dNiARBCLt01CijJzgStsc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KxEl+0yIHaoC/2sFKknwVY9LXHni1wZ8KvZPSue5iPljBfPw2GOrk5/Ql8LhrrS9E
	 MwrD9Q3ycnCM12f7vxumi3xZw4Zf16PD3R9uUHkwWJfIeonWwbXUpbtxDvZd5cag5h
	 YczD0wjIRbg85aHBwUKAtVlI/cPGiWuJHVWRObnKtJYDg/MaKijBsBgTYapTbGdFrB
	 g7U13so1jTcULm6OTjsv/l5nDwemjGx5md0hlKhWtNf6hp7T5Kqi4BfFh01guvhhwI
	 Nv/Ku5xUfhfZ3H+6lbo6zS7uVNG5zbk8nq12epPSKvYbW9t2bplUaNg3NkxXaA70Kb
	 ZbUsoCX+H+KaA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E4E6015C013F; Wed, 05 Feb 2025 00:26:51 -0500 (EST)
Date: Wed, 5 Feb 2025 00:26:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
        syzbot <syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, gustavoars@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in vfs_readlink
Message-ID: <20250205052651.GD909029@mit.edu>
References: <67a1e1f4.050a0220.163cdc.0063.GAE@google.com>
 <CAGudoHHCXHA=7e8M=6jMVqbh8=keRBBF8yHvDm9PnyeN6Bb7Xw@mail.gmail.com>
 <202502040717.FCEFDB7E0@keescook>
 <CAGudoHFszbdKkPibU_ynbj_PSyHewxTxWT_-hR3=8GHa46ebaQ@mail.gmail.com>
 <CAGudoHHWsuVse-Ek3zOuOh-mBxaWRXYVr9W_Uef46K0_mxB0ZA@mail.gmail.com>
 <20250204203059.GA909029@mit.edu>
 <CAGudoHFvLiCnCkAQN82qhdqmy0P2=Ywtnwqkc3KOc3s3hUQX8g@mail.gmail.com>
 <CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQoTMaDHg@mail.gmail.com>

On Tue, Feb 04, 2025 at 10:25:29PM +0100, Mateusz Guzik wrote:
> >
> > My question is if that's legitimate, I'm guessing not. If not, then
> > ext4 should complain about it.
> >
> > On stock kernel this happens to work because strlen finds the "right" size.
> >
> 
> So it occurred to me to check what fsck thinks about it.
> 
> I ran it twice in a row, it *removed* the problematic symlink.

Can you show me what's in the problematic symlink?  And does the
syzbot reproducer trigger a problem before adding your symlink
caching?

What would be really great if you couldcreate small focused test case
that shows what's going on --- ideally something like a 100k file
system, ala the file systems in the tests directory of the e2fsprogs
sources....

						- Ted
