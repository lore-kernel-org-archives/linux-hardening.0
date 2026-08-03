Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89476426ECF;
	Mon,  3 Aug 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780742; cv=none; b=YXFmui1Zea7ycXkeymg3CgBFWH4NSWADfZ3Ll4GeGeSGS14Mux2p8+gPCEByCQi9U+Cuh+2RUn3DpCRgqaVIX4GRDtUfPr6JoRSNMl9PQCZE/q+ZlQLHs2en3+qmtxd7RMle1zScXk6H5SUnlqwafj83GavRda/F/+QHsDyB5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780742; c=relaxed/simple;
	bh=gy+E/r3YRd4ie0M1QS88d9acz/SOMCsPmBalBftlLXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haK17QlWD+EW1ocxnD6UWd8AWwXwcMafyb2WC+QkF7Pik8csyWJ8rIn8l4u4rglYZYP8Tomy5d7clmq2asWnU1O8FCj/B6alIWU00qG22XzoUzq1e3Lnd2yj24g+sE5lsPfow+FZsScoWHy9J7g7Y0JH59cNYFbpa696PBOGwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeHOPPo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeHOPPo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03FE1F000E9;
	Mon,  3 Aug 2026 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780741;
	bh=caNw5de4BeQBAKorOGJf3ghVsp5LnmvH5cbGv3j3bnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NeHOPPo0TK3Ir5gyllRmAqkVovJVRwgPKNH1TDmtfEsRaPzzgaCSU3nqyr/SQa1MC
	 pZJJV646OTmfpTj0HPnNbo73w1Zg0hW5/QTMlbusGfp0vYbfNvubk/UVz4lSC+tJLs
	 lxNwDKeEtMYe+442XObTpxG/BipEJg7q2SHVfJNlEZ9+ej/riCSr9rLe9b72jZeGCQ
	 q3fGkRCmaqrcmFJ8eQoFrcIxV3hVsxKsul3rAn7hFAbupmdeNGwMUR6XNu0uhZvEnq
	 /wNsAs8lw1KXac8w4aJEVQ+LwcwVd7p+vPd3bgKhpYNlJCa1nAH02Bar2LgrsG3m7U
	 SF/SivItMZJcA==
Date: Mon, 3 Aug 2026 11:12:17 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Message-ID: <20260803181217.GB1067866@ax162>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
 <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
 <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
 <BN0PR02MB8128563CD267288E68943157E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <BN0PR02MB81287EC4BD8A7C0D7E6B5E31E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <amPIsTxtNPhbDU-z@levanger>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amPIsTxtNPhbDU-z@levanger>

On Fri, Jul 24, 2026 at 10:18:57PM +0200, Nicolas Schier wrote:
> On Wed, Jul 22, 2026 at 07:00:43PM +0000, Jaihind Yadav wrote:
> > 
> > Hi Nicolas Schier,
> > 
> > Thanks for the suggestion. I tested the proposed change:
> > 
> > -kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> > +kstack-erase-cflags-y += -fplugin=scripts/gcc-plugins/stackleak_plugin.so
> > 
> > 
> > Unfortunately, it does not work for the out-of-tree module builds in
> > my environment.
> 
> Thanks for checking; and yes I forgot out-of-tree modules.  When
> building them, Kbuild changes to their respective output directory so my
> suggestion had to fail for oot kmods.

Technically, this is only a problem for out of tree kernel modules,
right? When building in-tree kernel modules, objtree is always '.', so
we will never have the output directory path in the debug information
(at least based on my brief testing).

> > Given that the proposed relative path breaks out-of-tree module
> > builds, could you please take a look at the patch I posted? If the
> > approach looks reasonable, I would appreciate your review and
> > consideration for merging it.
> 
> I am not sure, if we can take your path, as 'readlink --relative-to' is
> only available in coreutils/Linux but coreutils are not a documented
> requirement for Linux builds (cp. Documentation/process/changes.rst),
> thus this would probably kill Linux builds on BSDs and Darwin/MacOS.
> 
> But let me think about that a few days;  and perhaps someone else comes
> up with an idea.

Yeah, I don't really like 'realpath --relative-to' either, it feels a
bit like a hack since it will only avoid including a full path if the
module output directory includes part of the build directory. For
example:

  O=/mnt/build/kernel
  MO=/mnt/build/extmod

$ realpath -m --relative-to /mnt/build/extmod /mnt/build/kernel
../kernel

vs.

  O=/home/nathan/build/kernel
  MO=/mnt/build/extmod

$ realpath -m --relative-to /mnt/build/extmod /home/nathan/build/kernel
../../../home/nathan/build/kernel

Furthermore, this patch only fixes KSTACK_ERASE but we have other GCC
plugins that presumably have the same problem.

I do not have a good solution for this either but since it only affects
external kernel modules, I am not particularly inclined to think too
hard about it.

-- 
Cheers,
Nathan
