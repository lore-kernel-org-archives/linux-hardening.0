Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B01D9663;
	Sat, 10 Oct 2026 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620932; cv=none; b=rok41A5RwKWFEKmWFAfl/UzaQfVy0uIvwMSkaTEkiJpd2xeyKn8mewR4Gxa6AGzR4wzizkTfajrJLn2xtTZaiy9bB4rzqOu0JbMRFsMma2g/HWMz/LGU4OV0xmfw0CMAOltbJCQTs0ANDw6QShmXpXk3t7znWDmKpd2GrG/vU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620932; c=relaxed/simple;
	bh=2YYS5zUxWQw21793grDzLNvpAiHCkpWrVO4auFEG6us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMrNUb5B7NBrWbbK0R/j3h7nXKCI71l3pxt2nJDvEgOvlnxy/5ofcg6IIyDiS3dXILRNEtw0Af0OXBb/5lRTaBGCSB/UJyam8Co/Y2/kwqu5KtIMuPI4evDeditqzGetSAwfSeUDoy8TJFeJGQGLxyrqkhuvX6lZ0fRDXC4VDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVPPQ488; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVPPQ488"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3FC1F000FF;
	Sat, 10 Oct 2026 08:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620930;
	bh=bPHyztbbhd+DO5iCNpZyiQoqthLFtvsGJzUV+noDqDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVPPQ488Spx/raCWhX0flPpN3UZnTMbHAxxt9f+hxmBeFdCs+MJUL0WY8WMT0ZnQR
	 qBEfSzEoqAtNF2ZsOP+ObHa3e/wjsu2p6yiyW4Tr9H9tyW0I90cxHbcJNxo0gUmmUE
	 h9byl0R9bDDixiZbUitrjES7kdUC8risFEBE8IT1ZPBG+Y+9LmIQ1XLJlfQSh8f0/l
	 ON4dc/Zrvx4E9nSqfZMcxqyTd8wbcHN5tiSqrne2gbpmAOEcUxT9LYpAhtr3V/9fNZ
	 9/3e6UuWXwwyfUDOKhWwVxVt4LrWpcb9xaW3JkppUYXrTtUa/KUroCXkjffSWT9o5W
	 5C7FQrBVFMeog==
Date: Sat, 10 Oct 2026 01:28:50 -0700
From: Kees Cook <kees@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <20261010082817.eddb2f-kees@kernel.org>
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
 <7fa8e996-d015-4f8d-a197-3f8901e0b31a@paulmck-laptop>
 <202610091923.FE842614D4@keescook>
 <7109f423-7249-49fb-a923-2824711fe197@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7109f423-7249-49fb-a923-2824711fe197@paulmck-laptop>

On Fri, Oct 09, 2026 at 09:27:57PM -0700, Paul E. McKenney wrote:
> 			foreground	background
> 			-next	Fix	-next	Fix
>
> 	make -jN	Bug	Good	Bug	Good
>
> 	kvm.sh [1]	Bug	Bug	Bug	Bug
>
> [1] tools/testing/selftests/rcutorture/bin/kvm.sh --build-only --allcpus --configs TREE02 --trust-make

Thanks for the details! IIUC, the difference is the config, not
foreground vs background. kvm-build.sh adds CONFIG_INITRAMFS_SOURCE,
which is compressed with gzip by default. The usr/Makefile target picks
that compressor through a variable, so v1 missed it. Your plain "make
-jN" builds probably had no built-in initramfs, so the kernel image was
the only place where pigz ran, which v1 did cover.

Hopefully v2 has all the missed targets fixed now:
https://lore.kernel.org/lkml/20261010081910.stay.092-kees@kernel.org/T/#m3b466b33f835119bfbd0c1b3c48d2a8a87f31691

-Kees

-- 
Kees Cook
