Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86618C31;
	Mon,  7 Apr 2025 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048957; cv=none; b=Jvh5FYs23QhqInU3N8VsTiaV9hjB9GhhX4ag+ITqWM5EX6J94t3pSwEbkZjliQY/QeptA5uJr6ypF4Gi/Mp2mgP+KOL4zSEldR50D1TZEM7HHCb+gktDhbmkuKrjeFULAjUUYt/zge9ExCiB7yIkxnU05KQ8LygWTyny9U/LQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048957; c=relaxed/simple;
	bh=gBFo43IEIITJ7hSSZuHxPa0NjVpoB6m9INwgzq49MyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayH/gLtXdvo3az4FXsTLGXyrcgKedW1kebXP/KCr9uli5tNI0g4FZwu7BJkBeOkHJSjqqQ2/IFEZs3OLGmALas/qt7n3gxxsI61ouUYvuXDyp/mWXTHqfyAzTlg2pZVGOllGp1B1Kx8oIyAdj6+CXXaWAwrxjyg/yW3s8ueUSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guqzBuCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guqzBuCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993A4C4CEDD;
	Mon,  7 Apr 2025 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744048956;
	bh=gBFo43IEIITJ7hSSZuHxPa0NjVpoB6m9INwgzq49MyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guqzBuCAHWfcRCFQJnU1BVUN192QF3ubQknho8VH38F6uw+sRlfYYTrRI85PSxzlG
	 dPOd4+vQGF9hthCp6gv5ybNFgtdcRqCo+r2bsncRRjd/Zl0egkhMTabCCUprtEzxVv
	 03kPPLtkAShXOD0CSJymVPnCCFsc+MzJLiQHe+qVHc2084vzmU6f6SDVQTYM0A3djK
	 XLgoMxE62zrVUhlAfBgu8eh0Q/62yNKRkV1rWQLL42WbST7TIB+hpqqNMecQnhvcAT
	 CrEX6gE1K04kxASM5uBqU4IL9R6tMKp1F+XHELFwjMNudGaIwN6QQQG62NTuLF9877
	 HBq/FdBcFX0Ww==
Date: Mon, 7 Apr 2025 11:02:33 -0700
From: Kees Cook <kees@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Mark Brown <broonie@kernel.org>,
	Ethan Carter Edwards <ethan@ethancedwards.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>, shumingf@realtek.com
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: initialize ret in
 asoc_sdw_rt_amp_spk_rtd_init()
Message-ID: <202504071101.02539FE673@keescook>
References: <20250210-soc_sdw_rt_amp-v1-1-1ee1afcd8941@ethancedwards.com>
 <ad5eb513-d3ef-42b8-b4a7-88a6ecf08804@sirena.org.uk>
 <a97bf84a-21e8-41ce-8679-332630136ec5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a97bf84a-21e8-41ce-8679-332630136ec5@linux.dev>

On Tue, Feb 11, 2025 at 12:54:52PM -0600, Pierre-Louis Bossart wrote:
> On 2/11/25 07:13, Mark Brown wrote:
> > On Mon, Feb 10, 2025 at 11:08:27PM -0500, Ethan Carter Edwards wrote:
> >> There is a possibility for an uninitialized *ret* variable to be
> >> returned in some code paths.
> >>
> >> Setting to 0 prevents a random value from being returned.
> > 
> > That'll shut up the warning but is the warning trying to tell us that
> > there's a logic bug somewhere in the function and we're for example
> > forgetting to look at a return value in some path in the function?
> 
> The problematic code is this:
> 
> for_each_rtd_codec_dais(rtd, i, codec_dai) {
> 	if (strstr(codec_dai->component->name_prefix, "-1"))
> 		ret = snd_soc_dapm_add_routes(&card->dapm, rt_amp_map, 2);
> 	else if (strstr(codec_dai->component->name_prefix, "-2"))
> 		ret = snd_soc_dapm_add_routes(&card->dapm, rt_amp_map + 2, 2);
> }
> 
> return ret;
> 
> I am not sure if it's possible that either the for_each does nothing or that the two branches are skipped, but certainly initializing the 'ret' value makes sense to me.
> 
> Bard, Shuming, what do you think?

I'm just skimming through patchwork and this patch doesn't seem to have
made any progress. What're next steps?

-Kees

-- 
Kees Cook
