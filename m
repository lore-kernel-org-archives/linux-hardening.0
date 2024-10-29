Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5B20408C;
	Tue, 29 Oct 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195428; cv=none; b=O/wjRpqUhffSgpF2YKncbsOuyRBJUM0L7bcuP4T4MdfkupJDHJHRJBQvK09Kcy1c3RKZIEM1dKnjoPC7hbqBoYSOEqaeYZjMUpEvrCnRn9aZ1jc8x5x028NgbPwoa/kWe5LO4OQhIFmzWQU8UetSI0ckTu0ZmGLG07yZ+UI25v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195428; c=relaxed/simple;
	bh=l2eZ1x4L7FVeLGEx8M58IpKnMVCKjsvAwgQ0wKrSN6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTWXCamuo0L9w/S3q72dd8VY52GdLjZcEXNYniX51tbcLMJc5+sohmf2ScHgu+ZPWyP8KgFJdCXoKXT0hgLGougPDJrTFDvAuEC2L/ERrIYJk0zs/2Nzd8hEQXpC3GXJkQCDmt5b9MKZKejESAXjopfwwAjGuGPQq0dolHjXqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7RfndZD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7RfndZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730195427; x=1761731427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l2eZ1x4L7FVeLGEx8M58IpKnMVCKjsvAwgQ0wKrSN6A=;
  b=g7RfndZDiyH666EoSqikuHhGEK4NoxhusGX8iJKOGMnfzjnWPPBTOMBk
   CzjHVtO7+4FYqM+UbPJ79OURVur5dQmsEfMElkxeESbq46t7pszG2fh6u
   Jge7Ppskyor/YC7Qz4E4RwuV6ZuZGiFLdsW4oRif8W3DG1klVQe+RW0x+
   tPj35C4WO3vW1qot+DQLvQoetzmFncn+WcNB0GyKqV6DV3r3GDMsPIcoZ
   YS/mGejxnj+lwyIJzq1rCrbOBQMpTG2iyVArKAY+bSQsySF6C+HmPqGl3
   06MOkJGdOX2U23nCoWxdAgWCoOso0E8eSWCJgZxYl8sZTtOY3ugmmDPZE
   Q==;
X-CSE-ConnectionGUID: zvQQnV1NRAeJbOUWTPp7qQ==
X-CSE-MsgGUID: JPTLWcJ4SG6bp03kP1Xedg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33620287"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33620287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 02:50:27 -0700
X-CSE-ConnectionGUID: y6v2tymxTNmAPMdGKhTssA==
X-CSE-MsgGUID: ZMGc0KROS5SN60Itnmn1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81835899"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 02:50:23 -0700
Message-ID: <987b8806-2ec7-41f7-bdeb-8f843c34a993@linux.intel.com>
Date: Tue, 29 Oct 2024 10:50:21 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dapm: fix bounds checker error in
 dapm_widget_list_create
To: Aleksei Vetrov <vvvvvv@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/2024 11:50 PM, Aleksei Vetrov wrote:
> The widgets array in the snd_soc_dapm_widget_list has a __counted_by
> attribute attached to it, which points to the num_widgets variable. This
> attribute is used in bounds checking, and if it is not set before the
> array is filled, then the bounds sanitizer will issue a warning or a
> kernel panic if CONFIG_UBSAN_TRAP is set.
> 
> This patch sets the size of the widgets list calculated with
> list_for_each as the initial value for num_widgets as it is used for
> allocating memory for the array. It is updated with the actual number of
> added elements after the array is filled.
> 
> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> ---
>   sound/soc/soc-dapm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index c34934c31ffec3970b34b24dcaa0826dfb7d8e86..99521c784a9b16a232a558029a2f3e88bd8ebfb1 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -1147,6 +1147,8 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
>   	if (*list == NULL)
>   		return -ENOMEM;
>   
> +	(*list)->num_widgets = size;
> +
>   	list_for_each_entry(w, widgets, work_list)
>   		(*list)->widgets[i++] = w;
>   

and after that there is (*list)->num_widgets = i;

Can this be somehow simplified to remove 'i', if it set before assignment?
