Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977741EBFFA
	for <linux-hardening@vger.kernel.org>; Mon, 28 Oct 2024 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156350; cv=none; b=nVkr9bOxTqJ2VJo/EgrhQnEDZWEQDu4yt3J4h0I66aRIRrq1WMFHq3u5CHdY1NqUcY8d5ojIiAGdGoPgXIB9uUhp+oaKUuVvHv/cyjXKIginstqleUbbDV5okMCYzeDhICYxtCKyfPh/fipqikOFt0VZgSmzZnJztzzGlFe134U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156350; c=relaxed/simple;
	bh=H/t8jDbwRTh/REXH2pl8OgTgkLRTmudFvt3oVAikvK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBFA1jjxh1TChqTljtYqK2lXzEqI7Q7hHhg0xwSXI34yZ+Odb+86Ykc/UWvlyjwEKwavSKGkOsBSuk1V0ilYVDgSEF0Qmb/AJxSej9/EBH+0AV3dD0KPnu584fdylCFfhVZa/qGJaYfLwYSivFr432J6Y449USBePOMb30HdDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=oUXGTPsa; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="oUXGTPsa"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id 5Sc6tVOEyvH7l5YhXtRC2D; Mon, 28 Oct 2024 22:59:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5YhWt5ZU7zWaB5YhWtWHnN; Mon, 28 Oct 2024 22:59:07 +0000
X-Authority-Analysis: v=2.4 cv=dfaG32Xe c=1 sm=1 tr=0 ts=6720173b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=IsARVQ0n29yx_Rua2DAA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5UaYzFJdgU1C4hYpGKcIDeteyto7PWAtRUJ7PAS1rzY=; b=oUXGTPsaRdRK/p60Sn96YcMjR3
	+xm2vZF3haxk12tLPq4C3AwRAOJ/1Foulc9Ezx+WDsJgk6LDIqvOvrnuS9ekhC4LrrF41AwGgVuWB
	df5RSb2eTvng5ln87COKz/b9VRY3qrL/AIGrM5gqVI/WwnjXRzHnTrGnQtoWfEK1IJItw4DW5SI/J
	5LFVMJnmG+8RinGOQ1bI3jLYHDp2wXidnQeqeOFGVwFEQBLmV1LdA7djHF0gBb+3jw1Dw+Vg5RhgQ
	3hRemnsxtag6xaCOYHGbr05+Um+o+r2ILF6ren92x06ppPzTUQrhXDvsqzgkFVOCKRc4hn3aV/QGC
	sl8AVrSA==;
Received: from [201.172.173.7] (port=40216 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5YhV-003JXD-1Y;
	Mon, 28 Oct 2024 17:59:06 -0500
Message-ID: <28ade5d1-d13a-4388-bd0b-f03211937abd@embeddedor.com>
Date: Mon, 28 Oct 2024 16:58:58 -0600
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
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241028-soc-dapm-bounds-checker-fix-v1-1-262b0394e89e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5YhV-003JXD-1Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:40216
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAAIy1dnR/fneTyDusKjZ59hel8l77BkDiQr+krsR1g/rZWpEuBPptm65yrUiq0tEEaZWK1JTgVPTSuaaRNbIkxgyKbDxUqETNwjePKs6gcKgF9EfaVj
 PXBvziE4ReqaOs8DVx2WbFhgnzarMsGnbLk4lMNv5h/oirNv9PfKSNOR/UT2EBATGPmSKPsoURaeLY1+CpMHgvTHxCGXP8tl62KUWTeAzOrxCP4ZrII1wSt/



On 28/10/24 16:50, Aleksei Vetrov wrote:
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

As in the previous patch, this should include the following tag
(and probably CC stable):

Fixes: 80e698e2df5b ("ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by")

Thanks
-- 
Gustavo

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
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241028-soc-dapm-bounds-checker-fix-5bae621455b2
> 
> Best regards,

