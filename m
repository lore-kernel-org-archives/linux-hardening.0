Received: from msa.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07D4C3D0;
	Sat, 18 May 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051294; cv=none; b=ohxoT27VZBovcuaKHBdGsWsiaPU51a7ngGnYu4iabb7kDrGf19YxkO2P2K9C4CyHftls5PPt7S0auJLRTVG+56gT/dl4dM3zsyLgm3wAt7D+Ac/T9K/CAD/JuZBKCQXo5BSVm/bNQ0980KBW0tlAsQE/Bta9tGd6ymzP1FPNI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051294; c=relaxed/simple;
	bh=+kFOEWGyzi6vIHf76jDzFA2imAlbQvBmIrpXmOVrhvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNliJaVI8aovnwBUJosQLrZXI1EQFRTwwRUI8tNjdEhchbhwYCZXsprkEWuII2gcmnTePYJf/u+ba45UBRp/070vgwcGx7kEFVmUEAD2bI62P0CkYAGF7kvQ6/9X1Vx9dhnDevm439Nn9IvB0VRcrhI+7dp1xWmKTmO+pWLMgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TCDtg3Be; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TCDtg3Be"
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8NKOsDKB5rcIM8NKOs66mv; Sat, 18 May 2024 18:54:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716051279;
	bh=NQUX/UKoeWYpHl5nclkHEYXVWH0iNXBos3sbtmi02Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=TCDtg3BeyPLHPzxmB8apkDFp5cEt851ceBSNxIPUG0zaEvoB1HXG9ADmllOSafhCV
	 xiMSRtrRg49ddbeGq9GBBTaiXYU9RwokOGiM6sEBkiLxmGY5axibYntwUYri5QU2PE
	 jYvKhi/zUtdYUXVh7X5PXZUgOxvIDHBl8qIGQDq1neVNDQxiJ/v7PSgNfBb5XeZHjW
	 wTEhDy7FrkJbaeMHWqV2+EFaCKZCkWNCFghQWXhaMG0/QMeySbDaywPAft9DzIOXUb
	 a/mvRt9YIiWc26GmA4Dvi8YXHGFPNcibmoHh2Wga8th0vqmO/ggx2ReILJ03dDXg1V
	 Mjeo8LUyqHyFw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 May 2024 18:54:39 +0200
X-ME-IP: 86.243.17.157
Message-ID: <34a6d812-b4ed-4465-b0ec-e641d185b9b1@wanadoo.fr>
Date: Sat, 18 May 2024 18:54:36 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/nvif: Avoid build error due to potential
 integer overflows
To: Guenter Roeck <linux@roeck-us.net>
Cc: airlied@gmail.com, dakr@redhat.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, jani.nikula@intel.com, javierm@redhat.com,
 kherbst@redhat.com, linux-kernel@vger.kernel.org, lyude@redhat.com,
 mripard@kernel.org, nouveau@lists.freedesktop.org, tzimmermann@suse.de,
 linux-hardening@vger.kernel.org
References: <20240518143743.313872-1-linux@roeck-us.net>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240518143743.313872-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(adding linux-hardening@vger.kernel.org)


Le 18/05/2024 à 16:37, Guenter Roeck a écrit :
> Trying to build parisc:allmodconfig with gcc 12.x or later results
> in the following build error.
> 
> drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_mthd':
> drivers/gpu/drm/nouveau/nvif/object.c:161:9: error:
> 	'memcpy' accessing 4294967264 or more bytes at offsets 0 and 32 overlaps 6442450881 bytes at offset -2147483617 [-Werror=restrict]
>    161 |         memcpy(data, args->mthd.data, size);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_ctor':
> drivers/gpu/drm/nouveau/nvif/object.c:298:17: error:
> 	'memcpy' accessing 4294967240 or more bytes at offsets 0 and 56 overlaps 6442450833 bytes at offset -2147483593 [-Werror=restrict]
>    298 |                 memcpy(data, args->new.data, size);
> 
> gcc assumes that 'sizeof(*args) + size' can overflow, which would result
> in the problem.
> 
> The problem is not new, only it is now no longer a warning but an error since W=1
> has been enabled for the drm subsystem and since Werror is enabled for test builds.
> 
> Rearrange arithmetic and add extra size checks to avoid the overflow.
> 
> Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
> Cc: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
> Cc: Danilo Krummrich <dakr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
> checkpatch complains about the line length in the description and the (pre-existing)
> assignlemts in if conditions, but I did not want to split lines in the description
> or rearrange the code further.
> 
> I don't know why I only see the problem with parisc builds (at least so far).
> 
>   drivers/gpu/drm/nouveau/nvif/object.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
> index 4d1aaee8fe15..baf623a48874 100644
> --- a/drivers/gpu/drm/nouveau/nvif/object.c
> +++ b/drivers/gpu/drm/nouveau/nvif/object.c
> @@ -145,8 +145,9 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
>   	u8 stack[128];
>   	int ret;
>   
> -	if (sizeof(*args) + size > sizeof(stack)) {
> -		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
> +	if (size > sizeof(stack) - sizeof(*args)) {
> +		if (size > INT_MAX ||
> +		    !(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))

Hi,

Would it be cleaner or better to use size_add(sizeof(*args), size)?

>   			return -ENOMEM;
>   	} else {
>   		args = (void *)stack;
> @@ -276,7 +277,8 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
>   	object->map.size = 0;
>   
>   	if (parent) {
> -		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL))) {
> +		if (size > INT_MAX ||
> +		    !(args = kmalloc(sizeof(*args) + size, GFP_KERNEL))) {

Same.

CJ

>   			nvif_object_dtor(object);
>   			return -ENOMEM;
>   		}

