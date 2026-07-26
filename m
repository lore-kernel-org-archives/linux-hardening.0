Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B451D435F;
	Sun, 26 Jul 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053466; cv=none; b=R9+4rWaCzVeNUu/zYJe673xVfuJ3rn3jH0bzfNlwjoc58lq7t60yPgp4PJRDuxWKG1Ip1El/LjyIe+JLhyOKOyxi/Llbvh4Y8DgO0qPWPvP+y5O8TCE4pVcsPbxDRGRjQP4K4YcbLYsMDBHdX3fnoF19WAtDvFflIzBkON/Fdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053466; c=relaxed/simple;
	bh=RTEPkriu0RzqeZbGXqTSNKnfnJCakanhFbBUxP0fP5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QL4a06seBY6MGuU13t3J1uNQrmi6zSSbRnKO2Ju/R8B2PQJsEZz6yii4ffy/KH2peD7Jje5pcOM3skM7h1USPqtCP7qsk6r9q6Yr05/sycIUgTwTWIuiLrJH6agYRETbVdMcCxw5Q5uyY8MhrEFVlF27dYWHzm9mRERZYtNyF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xhka52Pz; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xhka52Pz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785053457; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NEC1x0t4FgKK4Tk+cZJ1XYzOhN5QrXs0rC69ea0xDJw=;
	b=Xhka52PzVrXue4ORIq4yBJ17K/LwE00qlNrkkYVgaRlGy9dAqB/9gXxNDvvlUNwjvK1lQ2lVlES985isXjBZc4DgxLZgR5gdLM8mYYbnNLCX5k4mnPSO0muS8GSjpHwKEJxwtMTBioVZK5H6Kyq3misQcUEU/zuvRAHG9oAZHAg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X7n1mZ1_1785053455;
Received: from 30.28.192.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n1mZ1_1785053455 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 16:10:57 +0800
Message-ID: <22906668-658f-49a2-99f3-9e4ef6506d93@linux.alibaba.com>
Date: Sun, 26 Jul 2026 16:10:55 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 1/4] ACPI: APEI: GHES: Refactor Grace decoder
 helpers
To: Kai-Heng Feng <kaihengf@nvidia.com>, rafael@kernel.org, shuah@kernel.org,
 kees@kernel.org
Cc: julianbraha@gmail.com, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-hardening@vger.kernel.org, csoto@nvidia.com, mochs@nvidia.com
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260724122054.36162-2-kaihengf@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260724122054.36162-2-kaihengf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 8:20 PM, Kai-Heng Feng wrote:
> Split the Grace CPER processing into a separate decode step and a
> print step so the parser can be exercised by KUnit without a live
> ACPI device. Introduce ghes-nvidia.h to hold shared types that the
> Vera decoder added in the next commit will also reference.
> 
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
> v2:
>   - No change.
> 
>   drivers/acpi/apei/ghes-nvidia.c | 148 +++++++++++++++++++++-----------
>   drivers/acpi/apei/ghes-nvidia.h |  38 ++++++++
>   2 files changed, 137 insertions(+), 49 deletions(-)
>   create mode 100644 drivers/acpi/apei/ghes-nvidia.h
> 
> diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
> index 597275d81de8..af445152def0 100644
> --- a/drivers/acpi/apei/ghes-nvidia.c
> +++ b/drivers/acpi/apei/ghes-nvidia.c
> @@ -12,7 +12,10 @@
>   #include <linux/uuid.h>
>   #include <acpi/ghes.h>
>   
> -static const guid_t nvidia_sec_guid =
> +#include <kunit/visibility.h>
> +#include "ghes-nvidia.h"
> +
> +static const guid_t nvidia_grace_sec_guid =
>   	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
>   		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
>   
> @@ -25,10 +28,7 @@ struct cper_sec_nvidia {
>   	u8	number_regs;
>   	u8	reserved;
>   	__le64	instance_base;
> -	struct {
> -		__le64	addr;
> -		__le64	val;
> -	} regs[] __counted_by(number_regs);
> +	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
>   };

The Vera side treats the payload as a packed wire format and uses
get_unaligned_leXX(), but the Grace side still casts the CPER payload to
struct cper_sec_nvidia and directly dereferences __le16/__le64 fields.

Unless the GHES vendor payload is guaranteed to be naturally aligned here,
please make the Grace decoder follow the same rule as Vera and use
get_unaligned_le16()/get_unaligned_le64() for all multi-byte fields,
including the register pairs.

>   
>   struct nvidia_ghes_private {
> @@ -36,73 +36,123 @@ struct nvidia_ghes_private {
>   	struct device		*dev;
>   };
>   
> -static void nvidia_ghes_print_error(struct device *dev,
> -				    const struct cper_sec_nvidia *nvidia_err,
> -				    size_t error_data_length, bool fatal)
> +VISIBLE_IF_KUNIT
> +int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
> +			     size_t len,
> +			     struct nvidia_ghes_decoded *decoded)
>   {
> -	const char *level = fatal ? KERN_ERR : KERN_INFO;
> +	const struct cper_sec_nvidia *nvidia_err = buf;
>   	size_t min_size;
>   
> -	dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
> -	dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
> -	dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
> -	dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
> -	dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
> -	dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
> -	dev_printk(level, dev, "instance_base: 0x%016llx\n",
> -		   le64_to_cpu(nvidia_err->instance_base));
> -
> -	if (nvidia_err->number_regs == 0)
> -		return;
> -
> -	/*
> -	 * Validate that all registers fit within error_data_length.
> -	 * Each register pair is two little-endian u64s.
> -	 */
> +	if (!buf || !decoded)
> +		return -EINVAL;
> +	if (len < sizeof(*nvidia_err)) {
> +		if (dev)
> +			dev_err(dev, "Section too small (%zu < %zu)\n",
> +				len, sizeof(*nvidia_err));
> +		return -ENODATA;
> +	}
> +
>   	min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
> -	if (error_data_length < min_size) {
> -		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
> -			nvidia_err->number_regs, error_data_length, min_size);
> -		return;
> +	if (len < min_size) {
> +		if (dev)
> +			dev_err(dev,
> +				"Invalid number_regs %u (section size %zu, need %zu)\n",
> +				nvidia_err->number_regs, len, min_size);
> +		return -ENODATA;
>   	}
>   
> -	for (int i = 0; i < nvidia_err->number_regs; i++)
> +	memset(decoded, 0, sizeof(*decoded));
> +	decoded->format = NVIDIA_GHES_FORMAT_GRACE;
> +	memcpy(decoded->signature, nvidia_err->signature, sizeof(nvidia_err->signature));
> +	decoded->signature[sizeof(nvidia_err->signature)] = '\0';
> +	decoded->error_type = le16_to_cpu(nvidia_err->error_type);
> +	decoded->error_instance = le16_to_cpu(nvidia_err->error_instance);
> +	decoded->severity = nvidia_err->severity;
> +	decoded->socket = nvidia_err->socket;
> +	decoded->number_regs = nvidia_err->number_regs;
> +	decoded->instance_base = le64_to_cpu(nvidia_err->instance_base);
> +	if (nvidia_err->number_regs)
> +		decoded->grace_regs = nvidia_err->regs;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);
> +
> +VISIBLE_IF_KUNIT
> +int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
> +				      unsigned int index, u64 *addr, u64 *val)
> +{
> +	const struct nvidia_ghes_grace_reg *regs;
> +
> +	if (!decoded || decoded->format != NVIDIA_GHES_FORMAT_GRACE || !addr || !val)
> +		return -EINVAL;
> +	if (index >= decoded->number_regs)
> +		return -ERANGE;
> +
> +	regs = decoded->grace_regs;

This is fine for objects produced by nvidia_ghes_decode_grace(), but now
that the helper is visible to KUnit, please either document that contract
or reject number_regs != 0 && !decoded->grace_regs here.

Thanks.
Shuai

