Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244534F497
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142342; cv=none; b=tEmeiQOy4vsNSZfFxK+TbH5aa4A6Oq8iDenDnygqf6QW+JZDG82+ewrp1FM6yVZDqDvq8OwFy/tZBsp1X24RVJjy+yybqUPgwd1lh93KOns7GjAfG6OYb8XQ7WP4yEdufqJuSq7TCdDN9rFNbZ1ZqQpsMnrQti0yNDxc5hF3mRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142342; c=relaxed/simple;
	bh=Hpchx+TeVg+3320N2ZLza2s70qLylkvHKlXE793d4Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFOvpZ/TBdl0utMmBJUW1rJiE14DVqSgMTltFYXrv2gF+HStbOGYdPr1+8IFvUlNqpAQLxZd1K8aaoWQN5hy7Bu0Q8ERMcdQj5o9hohkJibp+E64RZTCxgwcm7DOE1P08ajL5sUrRIqm1tsLg6fuEWVbY1TGalK9XpHzBTu9No8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=U36gbV3M; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="U36gbV3M"
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 9E9PxYJl5aC0U9FnZx8mZL; Wed, 23 Sep 2026 05:45:41 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FnXxVMlUvfbR9FnYxoYJ8; Wed, 23 Sep 2026 05:45:40 +0000
X-Authority-Analysis: v=2.4 cv=X7FSKHTe c=1 sm=1 tr=0 ts=6ab36785
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=4ffO35K8LLM2FldQJH0A:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=/E5qcA3QzsXosiYS9VqPceYIRRHq3vwJ1GMOPH5S7j8=; b=U36gbV3Mix/x
	WIQjz6KImRom22m14NU17nkw2Fz9/BzozX7h8i445DOlqIky7qEU2Ko0uaWY72P3QKkAB2vwMh3DV
	z3GccUJyHkhSvmxM8MdZT9Dr2mByWNDmnsm5Uv64/k4mXHrwrZvUpQVro6qkg3CuafvSJ7ZyoARzF
	yWnVDH2AFHAjE/g7CftfEa2a4b4EyrC7MPNSj/S0d79W9lMYod2wX3hHhmBhoMngx5GcdWnpWx2h4
	UinxsBdLkVY0fMD6ot2o6xHlSzcgAS2BG3rxOUBLHbrlJPd0tB2IoWbjW+6/wCgzvMMDVTuNQ0Kym
	jfgitaiY82MPrUluK+MEqg==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:36818 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FnX-00000001zQT-0WFg;
	Wed, 23 Sep 2026 00:45:39 -0500
Message-ID: <8d82177e-5347-4e7e-898b-01cfe244e1af@embeddedor.com>
Date: Wed, 23 Sep 2026 14:45:34 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct
 adc5_device_data with __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
References: <20260922220950.2267270-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260922220950.2267270-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9FnX-00000001zQT-0WFg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:36818
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 39
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKfmOY5Gzs0F3Z7mLvYLSjJGkfdVTh1sSMOfCEXuI+VffWODhSHA9d42rgisN7jW166+tCZMKLeRb5sIN5weBI08E6NvJkJ99wzlA0F9dKlbV1OiAWcG
 jqStMKEBiGaOYxBgsufbaiU4RNU4eq3wIOYftRgpdOvKk1M01HFOr0k9doRc0kygF+qbeK/qQAqGpOiaVd/qqydgqyaa/7MDLZDP4MoMs/BWzjRgLGXbaLtf



On 9/23/26 07:09, Bill Wendling wrote:
> Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
> fields inside structures can be annotated with the '__counted_by_ptr'
> attribute to specify which field in the same structure holds the element
> count. This enables the compiler to perform runtime bounds checking on
> the pointer.
> 
> Annotate the "base" pointer field in "struct adc5_device_data" with the
> "__counted_by_ptr" attribute pointing to "num_sdams". The number of
> SDAMs is determined from the device property and assigned to "num_sdams"
> which is then used to initialize "base" via "devm_kcalloc".
> 
> By ensuring "num_sdams" is set to the correct element count prior to
> the "base" pointer allocation, and since the size of "base" is never
> reallocated or changed, this annotation is safe and will not cause any
> false-positive runtime bounds check panics or KASAN issues.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/iio/adc/qcom-adc5-gen3-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> index 39cbfcbdb101..b3e2c2f50e8f 100644
> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -137,7 +137,7 @@ struct adc5_sdam_data {
>    */
>   struct adc5_device_data {
>   	struct regmap *regmap;
> -	struct adc5_sdam_data *base;
> +	struct adc5_sdam_data *base __counted_by_ptr(num_sdams);
>   	int num_sdams;
>   };
>   

