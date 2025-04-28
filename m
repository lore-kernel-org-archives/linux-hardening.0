Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367E268FFF;
	Mon, 28 Apr 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843845; cv=none; b=KP+QNu7Y8qnkeC6JACnv1Wb5A/qOOG+a+cSK/6vvOqGwua2hWiYOUZlrkFGtlJcDqn8In5Tiqz++eknmFao+v9DyK/Cljk7fSuqjoAEapNqTKtBkW0ZB61uibzmt9dQJdCOJ1FxHKyGHg/vnu1H3L71jngntw64FNO5Vkldp2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843845; c=relaxed/simple;
	bh=lemq0WlyiYPKOz4ZlJK1Z0Iz2kxrqAihbWSTOP9Bc/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rt8/+X6SkzTBju8wZV7j5ET1OLKF6ms02DfHTptrRnpbqGdhBAGkPOpv5uU+ex2OHN0RKk4bNS9iddHJdKp1zMmP62SmQ+jJuKHB1bBz/ztok1TF1UEC1ntXNaYSVvb/HrNUc3qm/dALHVwfDLT43cLN8kGTdTZYXOwDBEn2ugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCyfF1SN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCyfF1SN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745843844; x=1777379844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lemq0WlyiYPKOz4ZlJK1Z0Iz2kxrqAihbWSTOP9Bc/w=;
  b=KCyfF1SNbR6sqyK1f4qJqD5z7YC6jJfcxgqZ9z+jNq9H3OAGHTnLroR3
   EpSUeyyGF7UjgdhpEhQ5Sg86xzlUx4qUkvaRtFeNKapedcs4GSFXZcBKL
   9fUS1By2t8f2lRbcsSE/Zey4PQyCGvKPw5yOMmKzKwdxHKnZRvRiBBWW4
   bBp+Nw3CTHndOX/uqrL4TqA3LPIvSy0Q0E3Bhr87NDqM8Ao+z/VyWaHyp
   SBzOmyG2uW8FgjNLTKfFNYBOz5UmjjLszemw2LZXHQxXs8Yek3OckoFk8
   v8HK1wK9KpyCIoM3wDIO1o3PkYnBiT22vwNrzcZXBDryMU28+1PgnGBZC
   w==;
X-CSE-ConnectionGUID: u4ijRB9nTay3v0B14fJFVA==
X-CSE-MsgGUID: 2FdgqztvSBeq5pcHV6zQQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47520774"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="47520774"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 05:37:23 -0700
X-CSE-ConnectionGUID: xxjgWQxfQBa2LbEbvdEngw==
X-CSE-MsgGUID: N2DtIr1zTu2/5Z4md6qsKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="133479337"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.249.122]) ([10.245.249.122])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 05:37:18 -0700
Message-ID: <a154e7eb-2708-411d-a494-868abe7052b7@linux.intel.com>
Date: Mon, 28 Apr 2025 15:38:30 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines
 allocation type
To: Kees Cook <kees@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250426062511.work.859-kees@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20250426062511.work.859-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/04/2025 09:25, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct snd_sof_pipeline **", but the returned type
> will be "struct snd_sof_widget **". These are the same size allocation
> (pointer size) but the types don't match. Adjust the allocation type to
> match the assignment.

It looks like that this is indeed an oversight and a bug introduced by a
mostly mechanical change (introduced in v6.3).

Can you add:
Fixes: 9c04363d222b ("ASoC: SOF: Introduce struct snd_sof_pipeline")

and:
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: <sound-open-firmware@alsa-project.org>
> Cc: <linux-sound@vger.kernel.org>
> ---
>  sound/soc/sof/ipc4-pcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
> index 1a2841899ff5..52903503cf3b 100644
> --- a/sound/soc/sof/ipc4-pcm.c
> +++ b/sound/soc/sof/ipc4-pcm.c
> @@ -784,7 +784,8 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
>  
>  		/* allocate memory for max number of pipeline IDs */
>  		pipeline_list->pipelines = kcalloc(ipc4_data->max_num_pipelines,
> -						   sizeof(struct snd_sof_widget *), GFP_KERNEL);
> +						   sizeof(*pipeline_list->pipelines),
> +						   GFP_KERNEL);
>  		if (!pipeline_list->pipelines) {
>  			sof_ipc4_pcm_free(sdev, spcm);
>  			return -ENOMEM;

-- 
Péter

