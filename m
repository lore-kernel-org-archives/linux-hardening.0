Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F02C1791;
	Wed, 30 Apr 2025 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046707; cv=none; b=nA8LGFxJhoqDsW1h64BWDGI1rUMG8HzgGuzkx5NmNXviTzVxDrIxOoxLwTUUxgWFQHFJ2BGS/eSypot8KUy/UFJeEcGFTJGlKJA7t83WVssONZtMoUe3fAOVVq4IiWVVDq2x07sTTlAn2fSuPFZVRm98VWqhbnciNEP5AHONoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046707; c=relaxed/simple;
	bh=+oZt3lo7Y2F6/fZVFJ0PrjPqbuylBLTW66xN7SmrGFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNWe0aH+Lgd3tnk7b9fg3+1hwrHboppucVZAcM0YgIc1gmW7nAzG5qsf7pXENORvPTNN4Ex8GJNRJhdHIAqTCmJxCRh/xLdWFGmeuw7MruzklDHnfqQdJNeqM/cNp8y/Bk6rbpmH+gsOgOok8OhOyM6PXfV7z/z1ZdH0fhbpIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETOwS0i8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETOwS0i8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE9FC4CEE7;
	Wed, 30 Apr 2025 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046707;
	bh=+oZt3lo7Y2F6/fZVFJ0PrjPqbuylBLTW66xN7SmrGFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETOwS0i8SnXHZeagSiIeajZxdgfgHcaeKLtlSL7pWSmnx8u8NyW9R9dZ8ChC0w/HD
	 BxA4lbaTfykvkmik5fPkjLF/muXrVzjntK9WEZd2sD6DV3MsY7wOKB1/G/2m/PaHrW
	 IyoaJ6AlAZMCjXxHNA4sLUd/2CJGrc5up0/EehtG2u75T1itL6Zwxnao8AZzZT+e1Z
	 SRbVTsLdaarXOXyImDN/sDlg1DQO0ic9FaNW4eBv/E6KDio+tsq4ly13W0lxQu5YvU
	 fXhv/r+2pET+xq3G9IT6q8FN8SdoOXtv01TmiXlSiY1oYfeF9g/UibP8GzD++GyehW
	 wrmLRfL6+UMKg==
Date: Wed, 30 Apr 2025 13:58:24 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines
 allocation type
Message-ID: <202504301357.0B1DB9FD@keescook>
References: <20250426062511.work.859-kees@kernel.org>
 <a154e7eb-2708-411d-a494-868abe7052b7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a154e7eb-2708-411d-a494-868abe7052b7@linux.intel.com>

On Mon, Apr 28, 2025 at 03:38:30PM +0300, Péter Ujfalusi wrote:
> 
> 
> On 26/04/2025 09:25, Kees Cook wrote:
> > In preparation for making the kmalloc family of allocators type aware,
> > we need to make sure that the returned type from the allocation matches
> > the type of the variable being assigned. (Before, the allocator would
> > always return "void *", which can be implicitly cast to any pointer type.)
> > 
> > The assigned type is "struct snd_sof_pipeline **", but the returned type
> > will be "struct snd_sof_widget **". These are the same size allocation
> > (pointer size) but the types don't match. Adjust the allocation type to
> > match the assignment.
> 
> It looks like that this is indeed an oversight and a bug introduced by a
> mostly mechanical change (introduced in v6.3).
> 
> Can you add:
> Fixes: 9c04363d222b ("ASoC: SOF: Introduce struct snd_sof_pipeline")
> 
> and:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Thanks! I can carry the patch if you'd like? I assumed this would go
through regular maintainers.

-Kees

-- 
Kees Cook
