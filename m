Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64D1DF960;
	Tue, 29 Oct 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203907; cv=none; b=uq0vM1be5kWphQ4bAbaR/JfWzhiifckalwvdcEzDKH5wTG8WZTFpAOAFt5kOUOYtWdIde0AnNCk+zEDuwod0l6C8xwQA2IgnnCPR3dGkocZWWovUKgGOwsVsdq0e3rTKJ/H1n6YlIJz0/0OYsiODxVUamiQcjr9HkAvS69OdThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203907; c=relaxed/simple;
	bh=iNNeGmZ/whg7z0Qy2x4NxLL1jI+rJGiNCT1foxcoXcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4ifXbr/AQW8NsL0QXB3X40Bew+cU6So/oO2yBCkyVJikRgHGlrAiHha6LpgWrDDl2ydqqLVBF3tpaGrvZojOJnUpWh+IWZoDGPU0I9Wo+v3YY9lrhoZq4zIUQTWfrp51jWTQ6xxRyxd4ubzKfn3Mb463ETctuyxc2dEMCqGkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrMQmL5V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrMQmL5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730203905; x=1761739905;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iNNeGmZ/whg7z0Qy2x4NxLL1jI+rJGiNCT1foxcoXcA=;
  b=JrMQmL5VyOu5nuA/H10+cdtI6tjWbn5OPfNkICLRMrjZspXVOJ2BZWwu
   PZ1RnXT0DVeXO4egb8EeypCartkyTCAF9bFunFAIxZp3MwSVOEyl6Y+YV
   /W7jYVqHNRdej0CcuMj1DcEM7MTycia15H5D4DiAWEzoWckrkY/BpMeTD
   XVa4q0LPiDWSrfFw0a8NZYMKh20GN0NnTWEvu0vqt76oLb7DEc3/2KC1M
   vsD9pGNaT36n4Sxf6JH/6XLFDLK676PfgpF6uO+c+Xl8ACp08NonHtbWl
   lOUIHrup2sKkHjyDRB+WRnHoxYRCpcBXRuWsy/Ghxfn9qj4026YuAsFmc
   g==;
X-CSE-ConnectionGUID: z7IkeBHZRf65lTp1s+ZEfQ==
X-CSE-MsgGUID: 8IAwk8UOT2S1PRSa4/7IGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29959256"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29959256"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:11:43 -0700
X-CSE-ConnectionGUID: UfnwoUnyRAaqyMAaoBzDqw==
X-CSE-MsgGUID: wI4q/vKuSnOtVMPyCM83xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86553696"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 05:11:35 -0700
Message-ID: <c9002b28-77a9-4be0-94a6-bf700e0abaab@linux.intel.com>
Date: Tue, 29 Oct 2024 13:11:32 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
To: Takashi Iwai <tiwai@suse.de>
Cc: Aleksei Vetrov <vvvvvv@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
 <987b8806-2ec7-41f7-bdeb-8f843c34a993@linux.intel.com>
 <87plnj19ry.wl-tiwai@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <87plnj19ry.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/2024 11:30 AM, Takashi Iwai wrote:
> On Tue, 29 Oct 2024 10:50:21 +0100,
> Amadeusz Sławiński wrote:
>>
>> On 10/28/2024 11:50 PM, Aleksei Vetrov wrote:
>>> The widgets array in the snd_soc_dapm_widget_list has a __counted_by
>>> attribute attached to it, which points to the num_widgets variable. This
>>> attribute is used in bounds checking, and if it is not set before the
>>> array is filled, then the bounds sanitizer will issue a warning or a
>>> kernel panic if CONFIG_UBSAN_TRAP is set.
>>>
>>> This patch sets the size of the widgets list calculated with
>>> list_for_each as the initial value for num_widgets as it is used for
>>> allocating memory for the array. It is updated with the actual number of
>>> added elements after the array is filled.
>>>
>>> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
>>> ---
>>>    sound/soc/soc-dapm.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>>> index c34934c31ffec3970b34b24dcaa0826dfb7d8e86..99521c784a9b16a232a558029a2f3e88bd8ebfb1 100644
>>> --- a/sound/soc/soc-dapm.c
>>> +++ b/sound/soc/soc-dapm.c
>>> @@ -1147,6 +1147,8 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
>>>    	if (*list == NULL)
>>>    		return -ENOMEM;
>>>    +	(*list)->num_widgets = size;
>>> +
>>>    	list_for_each_entry(w, widgets, work_list)
>>>    		(*list)->widgets[i++] = w;
>>>    
>>
>> and after that there is (*list)->num_widgets = i;
>>
>> Can this be somehow simplified to remove 'i', if it set before assignment?
> 
> That line can be removed after this change, I suppose.
> The size is calculated from the list at the beginning, and it must be
> the exact size.
> 

Actually looking at this again, first iteration iterates through all 
widgets, while second one, only through work_list, which looks to me 
like it allocates more memory than needed in most cases.

