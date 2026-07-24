Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763EDF59;
	Fri, 24 Jul 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924352; cv=none; b=opHEsFlCJKEpy2NBb2O9Df0T8PROxBeNrNT3jrLkFwxiYBtHW3b4yK2YqdaI7z1basl1cdKvYSQBP8qPdAm2P1w77pdd9mgUQIlbueRexPtEsu1KJSFi3u/R+AWRmZdgw6doUbB9viB/dzhi0uiA4yxPVY5xTjEZX+0Ia6pbtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924352; c=relaxed/simple;
	bh=F8pv8ZtMdMy2sKuwqOo3k21G20JmtUijCyOJ9VQXJ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3M2gqAQoRiLAZcA1NlLq6WQE3L+MoIjMAyKYdM299OMT8Va0qRcG3yeIl+HPIkWc82kZOF6b/CtgPoYS1sEGISGJpQ7yBFB0YQmyLRr0TYx6MgMVq9+S797ZA1nocXg1vxplLH6v2v9HHvu9l+waxhPZmAEe/vpBfDqlDREwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDt7J7pE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDt7J7pE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B2C8A1F00A3A;
	Fri, 24 Jul 2026 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784924351;
	bh=FSNQ6GqoIeIZ5E8+i3tXupSJAI0/yjJLUQZooZGnT20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDt7J7pErgkYDDFNeOZ4y0uTYofor9Or7o4zG0d1c5RtDJHXsjApj6qYROhqTcErb
	 17xu3+ZrBff7yjN9DjZ3S2WyuNl/R+4hhcyNXpiNT2LGmf2fpAqqgmnM9mIjozMCiq
	 /JcXhPv2mKEU6iTBx75S78cAzCUPWLdy7WkgsTXBXfsgEJ5Eh8z17bgtqACP64hzD/
	 R+U4IOeyN+wGIufejmYtxDKYoKcPljMoNNxZrRpyqUph1jhsFM9vDmE5iOYOe1L83D
	 La+e/M9sul6Ir8tNzTrzFu3WkuG5Lv6dhXOnlRoZw08Zl308iSHZA7F8/DESgKMgxq
	 011KYJ0GTjtOQ==
Date: Fri, 24 Jul 2026 22:18:57 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: "nathan@kernel.org" <nathan@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scripts: kstack_erase: use relative stackleak plugin
 path
Message-ID: <amPIsTxtNPhbDU-z@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Jaihind Yadav <jaihindy@qti.qualcomm.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260720093545.3836066-1-jaihindy@qti.qualcomm.com>
 <20260720093545.3836066-2-jaihindy@qti.qualcomm.com>
 <20260722-ubiquitous-stork-of-hail-3ba047@l-nschier-aarch64>
 <BN0PR02MB8128563CD267288E68943157E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
 <BN0PR02MB81287EC4BD8A7C0D7E6B5E31E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0PR02MB81287EC4BD8A7C0D7E6B5E31E2C12@BN0PR02MB8128.namprd02.prod.outlook.com>

On Wed, Jul 22, 2026 at 07:00:43PM +0000, Jaihind Yadav wrote:
> 
> Hi Nicolas Schier,
> 
> Thanks for the suggestion. I tested the proposed change:
> 
> -kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
> +kstack-erase-cflags-y += -fplugin=scripts/gcc-plugins/stackleak_plugin.so
> 
> 
> Unfortunately, it does not work for the out-of-tree module builds in
> my environment.

Thanks for checking; and yes I forgot out-of-tree modules.  When
building them, Kbuild changes to their respective output directory so my
suggestion had to fail for oot kmods.

[...]
> Given that the proposed relative path breaks out-of-tree module
> builds, could you please take a look at the patch I posted? If the
> approach looks reasonable, I would appreciate your review and
> consideration for merging it.

I am not sure, if we can take your path, as 'readlink --relative-to' is
only available in coreutils/Linux but coreutils are not a documented
requirement for Linux builds (cp. Documentation/process/changes.rst),
thus this would probably kill Linux builds on BSDs and Darwin/MacOS.

But let me think about that a few days;  and perhaps someone else comes
up with an idea.

Kind regards,
Nicolas
