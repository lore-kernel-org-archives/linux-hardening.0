Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB442F5A36;
	Sun, 26 Jul 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054079; cv=none; b=Q5eRMk15hfTrH1vS2j2iHpJJ18sz7MyVK3NGqiWcsTMhJWS1hG7AHNi5eEinWUMyHQLdFoLwhNWCQO50w0awkoFf+jKUapSqcf/CKpegdjOdXc9zjZutnEeNKcCi1NMVZZRli0Sako2iFST7QHWSQaoDvAp86KRFtsqJLtsqFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054079; c=relaxed/simple;
	bh=sCo7LbaeO72bLiCXa6MxDaO/vLxgWgk+x6qNtwf2bpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty8NB5RSnp+Hg18k2jaZeegQIg7LQGvr+W0qqkRQtAUkYhMT3K/X4EIhIUqpiSpFYMFO6a1r8X3JzwOtiAxm77Lwyj8aDA+ngZCl+hHkeO4/aMfaQmfa2B3W9vVy2n1yT9q2ihTSdJ/5x2Nls0WU5ndCBS3v8AUSClssZ1exmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EHbSAEPw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EHbSAEPw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785054071; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p5EWEhOGdiD+9Kf3bXEZ+yz7gK5y93XGxx3lYbj7PzU=;
	b=EHbSAEPwokU+1UfFPuhxUpO71Ccot48MGkZpMisrHdZldQXaSR0EzJLY9uWXMPfxm2VzuC95Ny0fnTnxMdDk0DMvUUP7D+VPdOCKF31NYXZf4xCKrmZcIBskwlSYkUvYkARL6j1bsj67cv+50/5O6P943UXVhZMv4Tl9MWO7UDs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X7n9pUQ_1785054070;
Received: from 30.28.192.31(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n9pUQ_1785054070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 16:21:11 +0800
Message-ID: <9653454a-7cc7-4dfa-b098-f1c70ddecf71@linux.alibaba.com>
Date: Sun, 26 Jul 2026 16:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND 2/4] ACPI: APEI: GHES: Add NVIDIA Vera decoder
To: Kai-Heng Feng <kaihengf@nvidia.com>, rafael@kernel.org, shuah@kernel.org,
 kees@kernel.org
Cc: julianbraha@gmail.com, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-hardening@vger.kernel.org, csoto@nvidia.com, mochs@nvidia.com
References: <20260724122054.36162-1-kaihengf@nvidia.com>
 <20260724122054.36162-3-kaihengf@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260724122054.36162-3-kaihengf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 8:20 PM, Kai-Heng Feng wrote:
> Vera is NVIDIA's next-generation server SoC. Its CPER section uses a
> different GUID and a different binary layout from Grace, so it needs
> its own decoder. Without this, firmware-reported hardware errors on
> Vera platforms are received but not decoded.
> 
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>   drivers/acpi/apei/ghes-nvidia.c | 368 ++++++++++++++++++++++++++++++--
>   drivers/acpi/apei/ghes-nvidia.h |  29 ++-
>   2 files changed, 382 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
> index af445152def0..c74c155dd2ba 100644
> --- a/drivers/acpi/apei/ghes-nvidia.c
> +++ b/drivers/acpi/apei/ghes-nvidia.c
> @@ -7,18 +7,27 @@
>   
>   #include <linux/acpi.h>
>   #include <linux/module.h>
> +#include <linux/overflow.h>
>   #include <linux/platform_device.h>
> +#include <linux/slab.h>
>   #include <linux/types.h>
> +#include <linux/unaligned.h>
>   #include <linux/uuid.h>
> +#include <kunit/visibility.h>
>   #include <acpi/ghes.h>
>   
> -#include <kunit/visibility.h>
>   #include "ghes-nvidia.h"
>   
> +#define NVIDIA_GHES_VERA_VERSION	1
> +
>   static const guid_t nvidia_grace_sec_guid =
>   	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
>   		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
>   
> +static const guid_t nvidia_vera_sec_guid =
> +	GUID_INIT(0x9068e568, 0x6ca0, 0x11f0,
> +		  0xae, 0xaf, 0x15, 0x93, 0x43, 0x59, 0x1e, 0xac);
> +
>   struct cper_sec_nvidia {
>   	char	signature[16];
>   	__le16	error_type;
> @@ -31,11 +40,51 @@ struct cper_sec_nvidia {
>   	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
>   };
>   
> +struct cper_sec_nvidia_vera_event {
> +	u8	version;
> +	u8	event_context_count;
> +	u8	source_device_type;
> +	u8	reserved;
> +	__le16	event_type;
> +	__le16	event_sub_type;
> +	__le64	event_link_id;
> +	char	source_module_signature[16];
> +} __packed;
> +
> +struct cper_sec_nvidia_vera_cpu_info {
> +	__le16	info_version;
> +	u8	info_size;
> +	u8	socket_number;
> +	__le32	architecture;
> +	u8	chip_serial_number[16];
> +	__le64	instance_base;
> +} __packed;
> +
> +struct cper_sec_nvidia_vera_context {
> +	__le32	context_size;
> +	__le16	context_version;
> +	__le16	reserved;
> +	__le16	data_format_type;
> +	__le16	data_format_version;
> +	__le32	data_size;
> +} __packed;
> +
>   struct nvidia_ghes_private {
>   	struct notifier_block	nb;
>   	struct device		*dev;
>   };
>   
> +VISIBLE_IF_KUNIT
> +enum nvidia_ghes_format nvidia_ghes_format_from_guid(const guid_t *guid)
> +{
> +	if (guid_equal(guid, &nvidia_grace_sec_guid))
> +		return NVIDIA_GHES_FORMAT_GRACE;
> +	if (guid_equal(guid, &nvidia_vera_sec_guid))
> +		return NVIDIA_GHES_FORMAT_VERA;
> +	return NVIDIA_GHES_FORMAT_UNKNOWN;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_format_from_guid);
> +
>   VISIBLE_IF_KUNIT
>   int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
>   			     size_t len,
> @@ -81,7 +130,7 @@ EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);
>   
>   VISIBLE_IF_KUNIT
>   int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
> -				      unsigned int index, u64 *addr, u64 *val)
> +			       unsigned int index, u64 *addr, u64 *val)
>   {
>   	const struct nvidia_ghes_grace_reg *regs;
>   
> @@ -98,6 +147,220 @@ int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
>   }
>   EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_grace_reg_pair);
>   
> +static int nvidia_ghes_vera_validate_context_data(u16 data_format_type,
> +						  u32 data_size)
> +{
> +	switch (data_format_type) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		return data_size % 16 ? -EINVAL : 0;
> +	case 2:
> +	case 3:
> +		return data_size % 8 ? -EINVAL : 0;
> +	case 4:
> +		return data_size % 4 ? -EINVAL : 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +VISIBLE_IF_KUNIT
> +int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
> +			    size_t len,
> +			    struct nvidia_ghes_decoded *decoded)
> +{
> +	const struct cper_sec_nvidia_vera_event *event = buf;
> +	const struct cper_sec_nvidia_vera_cpu_info *cpu_info;
> +	const struct cper_sec_nvidia_vera_context *context;
> +	const u8 *bytes = buf;
> +	size_t data_end_advance;
> +	size_t advance;
> +	size_t offset;
> +	int ret;
> +
> +	if (!buf || !decoded)
> +		return -EINVAL;
> +	if (len < sizeof(*event)) {
> +		if (dev)
> +			dev_err_ratelimited(dev, "Vera event header truncated (%zu < %zu)\n",
> +					    len, sizeof(*event));
> +		return -ENODATA;
> +	}
> +	if (event->version != NVIDIA_GHES_VERA_VERSION)
> +		return -EOPNOTSUPP;
> +	if (event->source_device_type != 0)
> +		return -EOPNOTSUPP;
> +
> +	offset = sizeof(*event);
> +	if (len - offset < sizeof(*cpu_info)) {
> +		if (dev)
> +			dev_err_ratelimited(dev, "Vera CPU info truncated (%zu < %zu)\n",
> +					    len - offset, sizeof(*cpu_info));
> +		return -ENODATA;
> +	}
> +
> +	cpu_info = (const void *)(bytes + offset);
> +	if (cpu_info->info_size < sizeof(*cpu_info)) {
> +		if (dev)
> +			dev_err_ratelimited(dev, "Vera CPU info size %u smaller than header %zu\n",
> +					    cpu_info->info_size, sizeof(*cpu_info));
> +		return -EINVAL;
> +	}
> +	if (len - offset < cpu_info->info_size) {
> +		if (dev)
> +			dev_err_ratelimited(dev, "Vera CPU info extends past section (%u > %zu)\n",
> +					    cpu_info->info_size, len - offset);
> +		return -ENODATA;
> +	}
> +
> +	offset += cpu_info->info_size;
> +	if (event->event_context_count > NVIDIA_GHES_MAX_CONTEXTS) {
> +		if (dev)
> +			dev_err_ratelimited(dev, "Vera context count %u exceeds maximum %u\n",
> +					    event->event_context_count,
> +					    NVIDIA_GHES_MAX_CONTEXTS);
> +		return -E2BIG;
> +	}
> +
> +	memset(decoded, 0, sizeof(*decoded));
> +	decoded->format = NVIDIA_GHES_FORMAT_VERA;
> +	memcpy(decoded->signature, event->source_module_signature,
> +	       sizeof(event->source_module_signature));
> +	decoded->signature[sizeof(event->source_module_signature)] = '\0';
> +	decoded->event_context_count = event->event_context_count;
> +	decoded->source_device_type = event->source_device_type;
> +	decoded->event_type = get_unaligned_le16(&event->event_type);
> +	decoded->event_sub_type = get_unaligned_le16(&event->event_sub_type);
> +	decoded->event_link_id = get_unaligned_le64(&event->event_link_id);
> +	decoded->socket = cpu_info->socket_number;
> +	decoded->architecture = get_unaligned_le32(&cpu_info->architecture);
> +	memcpy(decoded->chip_serial_number, cpu_info->chip_serial_number,
> +	       sizeof(cpu_info->chip_serial_number));
> +	decoded->instance_base = get_unaligned_le64(&cpu_info->instance_base);
> +
> +	for (int i = 0; i < event->event_context_count; i++) {
> +		struct nvidia_ghes_vera_context *decoded_context = &decoded->contexts[i];
> +		u32 context_size;
> +		u32 data_size;
> +		u16 data_format_type;
> +
> +		if (len - offset < sizeof(*context)) {
> +			if (dev)
> +				dev_err_ratelimited(dev, "Vera context[%d] header truncated (%zu < %zu)\n",
> +						    i, len - offset, sizeof(*context));
> +			return -ENODATA;
> +		}
> +
> +		context = (const void *)(bytes + offset);
> +		context_size = get_unaligned_le32(&context->context_size);
> +		data_format_type = get_unaligned_le16(&context->data_format_type);
> +		data_size = get_unaligned_le32(&context->data_size);
> +
> +		if (context_size < sizeof(*context)) {
> +			if (dev)
> +				dev_err_ratelimited(dev,
> +						    "Vera context[%d] size %u smaller than header %zu\n",
> +						    i, context_size, sizeof(*context));
> +			return -EINVAL;
> +		}
> +		if (data_format_type > 4) {
> +			if (dev)
> +				dev_dbg(dev,
> +					"Vera context[%d] unsupported data format %u\n",
> +					i, data_format_type);
> +			return -EOPNOTSUPP;
> +		}
> +		if (check_add_overflow((size_t)data_size, sizeof(*context),
> +				       &data_end_advance)) {
> +			if (dev)
> +				dev_err_ratelimited(dev,
> +						    "Vera context[%d] data_size %u overflows section accounting\n",
> +						    i, data_size);
> +			return -EOVERFLOW;
> +		}
> +
> +		if (data_end_advance > len - offset) {
> +			if (dev)
> +				dev_err_ratelimited(dev,
> +						    "Vera context[%d] data extends past section (%zu > %zu)\n",
> +						    i, data_end_advance, len - offset);
> +			return -ENODATA;
> +		}
> +
> +		/*
> +		 * Some Vera payloads use only the header size here and
> +		 * place the format-specific payload immediately after it.
> +		 */
> +		if (context_size == sizeof(*context))
> +			advance = data_end_advance;
> +		else if (data_size <= context_size - sizeof(*context))
> +			advance = context_size;
> +		else {
> +			if (dev)
> +				dev_err_ratelimited(dev,
> +						    "Vera context[%d] data_size %u exceeds context_size %u\n",
> +						    i, data_size, context_size);
> +			return -EINVAL;
> +		}

This is the part that I would like to understand better before relying on
this parser in production.

The code accepts two different encodings:

   - context_size == sizeof(*context), with the payload length coming from
     data_size, and
   - context_size covering both the context header and the payload.

If both forms are part of the Vera CPER ABI, please make that explicit in
the comment, preferably with the terminology used by the firmware
specification.  Otherwise this looks like the parser is guessing around
ambiguous firmware data.

Please also add a KUnit case with more than one context, ideally covering
the second form where context_size is larger than the header and the next
context is found via offset += context_size.  That would test the most
important offset accounting rule here.


> +
> +		if (advance > len - offset) {
> +			if (dev)
> +				dev_err_ratelimited(dev,
> +						    "Vera context[%d] advance %zu extends past section (%zu)\n",
> +						    i, advance, len - offset);
> +			return -ENODATA;
> +		}
> +
> +		ret = nvidia_ghes_vera_validate_context_data(data_format_type, data_size);
> +		if (ret) {
> +			if (dev)
> +				dev_err_ratelimited(dev,
> +						    "Vera context[%d] format %u rejected data_size %u (ret=%d)\n",
> +						    i, data_format_type, data_size, ret);
> +			return ret;
> +		}
> +
> +		decoded_context->context_size = context_size;
> +		decoded_context->context_version =
> +			get_unaligned_le16(&context->context_version);
> +		decoded_context->data_format_type = data_format_type;
> +		decoded_context->data_format_version =
> +			get_unaligned_le16(&context->data_format_version);
> +		decoded_context->data_size = data_size;
> +		decoded_context->data = bytes + offset + sizeof(*context);
> +		offset += advance;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_vera);
> +
> +VISIBLE_IF_KUNIT
> +int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx)
> +{
> +	if (!ctx)
> +		return -EINVAL;
> +	if (ctx->data_size > INT_MAX)
> +		return -EOVERFLOW;
> +
> +	switch (ctx->data_format_type) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		return ctx->data_size / 16;
> +	case 2:
> +		return ctx->data_size / 8;
> +	case 3:
> +		return ctx->data_size / 8;
> +	case 4:
> +		return ctx->data_size / 4;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_entry_count);
> +
>   static void nvidia_ghes_print_grace(struct device *dev,
>   				    const struct nvidia_ghes_decoded *decoded,
>   				    bool fatal)
> @@ -111,7 +374,8 @@ static void nvidia_ghes_print_grace(struct device *dev,
>   	dev_printk(level, dev, "severity: %u\n", decoded->severity);
>   	dev_printk(level, dev, "socket: %u\n", decoded->socket);
>   	dev_printk(level, dev, "number_regs: %u\n", decoded->number_regs);
> -	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
> +	dev_printk(level, dev, "instance_base: 0x%016llx\n",
> +		   decoded->instance_base);
>   
>   	for (int i = 0; i < decoded->number_regs; i++) {
>   		if (nvidia_ghes_grace_reg_pair(decoded, i, &addr, &val))
> @@ -121,12 +385,52 @@ static void nvidia_ghes_print_grace(struct device *dev,
>   	}
>   }
>   
> +static void nvidia_ghes_print_vera(struct device *dev,
> +				   const struct nvidia_ghes_decoded *decoded,
> +				   bool fatal, unsigned long ghes_severity)
> +{
> +	const char *level = fatal ? KERN_ERR : KERN_INFO;
> +
> +	dev_printk(level, dev, "signature: %s\n", decoded->signature);
> +	dev_printk(level, dev, "event_type: %u\n", decoded->event_type);
> +	dev_printk(level, dev, "event_sub_type: %u\n", decoded->event_sub_type);
> +	dev_printk(level, dev, "ghes_severity: %lu\n", ghes_severity);
> +	dev_printk(level, dev, "event_link_id: 0x%016llx\n",
> +		   decoded->event_link_id);
> +	dev_printk(level, dev, "socket: %u\n", decoded->socket);
> +	dev_printk(level, dev, "architecture: 0x%x\n", decoded->architecture);
> +	dev_printk(level, dev, "chip_serial_number: %*phN\n",
> +		   (int)sizeof(decoded->chip_serial_number),
> +		   decoded->chip_serial_number);
> +	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
> +	dev_printk(level, dev, "event_context_count: %u\n", decoded->event_context_count);
> +
> +	for (int i = 0; i < decoded->event_context_count; i++) {
> +		const struct nvidia_ghes_vera_context *ctx = &decoded->contexts[i];
> +		int entries = nvidia_ghes_vera_context_entry_count(ctx);
> +
> +		dev_printk(level, dev,
> +			   "context[%d]: version=%u format=%u format_version=%u context_size=%u data_size=%u\n",
> +			   i, ctx->context_version, ctx->data_format_type,
> +			   ctx->data_format_version, ctx->context_size, ctx->data_size);
> +		if (ctx->data_format_type == 0 && ctx->data_size > 0) {
> +			int prefix_len = ctx->data_size > 16 ? 16 : ctx->data_size;
> +
> +			dev_printk(level, dev, "context[%d]_opaque_prefix: %*phN\n",
> +				   i, prefix_len, ctx->data);
> +		} else if (entries >= 0) {
> +			dev_printk(level, dev, "context[%d]_entries: %d\n", i, entries);
> +		}
> +	}
> +}
> +
>   static int nvidia_ghes_notify(struct notifier_block *nb,
>   			      unsigned long event, void *data)
>   {
>   	struct acpi_hest_generic_data *gdata = data;
> -	struct nvidia_ghes_decoded decoded;
> +	struct nvidia_ghes_decoded *decoded;
>   	struct nvidia_ghes_private *priv;
> +	enum nvidia_ghes_format format;
>   	const void *payload;
>   	guid_t sec_guid;
>   	u32 len;
> @@ -134,26 +438,64 @@ static int nvidia_ghes_notify(struct notifier_block *nb,
>   	bool fatal;
>   
>   	import_guid(&sec_guid, gdata->section_type);
> -	if (!guid_equal(&sec_guid, &nvidia_grace_sec_guid))
> +	format = nvidia_ghes_format_from_guid(&sec_guid);
> +	if (format == NVIDIA_GHES_FORMAT_UNKNOWN)
>   		return NOTIFY_DONE;
>   
>   	priv = container_of(nb, struct nvidia_ghes_private, nb);
>   	len = acpi_hest_get_error_length(gdata);
> +
>   	payload = acpi_hest_get_payload(gdata);
>   	fatal = event >= GHES_SEV_RECOVERABLE;
> +	decoded = kzalloc_obj(*decoded);
> +	if (!decoded) {
> +		dev_err_ratelimited(priv->dev,
> +				    "Failed to allocate NVIDIA CPER decode buffer\n");
> +		return NOTIFY_OK;
> +	}

This runs from the GHES vendor workqueue, so sleeping allocation is not
the issue.  But this is still the error reporting path, and struct
nvidia_ghes_decoded looks small enough to avoid a per-event allocation.
Please consider keeping it on the stack, or explain why heap allocation
is needed here.

> +
> +	switch (format) {
> +	case NVIDIA_GHES_FORMAT_GRACE:
> +		ret = nvidia_ghes_decode_grace(priv->dev, payload, len, decoded);
> +		break;
> +	case NVIDIA_GHES_FORMAT_VERA:
> +		ret = nvidia_ghes_decode_vera(priv->dev, payload, len, decoded);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
>   
> -	ret = nvidia_ghes_decode_grace(priv->dev, payload, len, &decoded);
>   	if (ret) {
> -		dev_err(priv->dev,
> -			"Malformed NVIDIA CPER section, error_data_length: %u, ret: %d\n",
> -			len, ret);
> -		return NOTIFY_OK;
> +		if (ret == -EOPNOTSUPP && format == NVIDIA_GHES_FORMAT_VERA)
> +			dev_info(priv->dev,
> +				 "Unsupported NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
> +				 len, ret);
> +		else if (format == NVIDIA_GHES_FORMAT_GRACE)
> +			dev_err(priv->dev,
> +				"Malformed NVIDIA Grace CPER section, error_data_length: %u, ret: %d\n",
> +				len, ret);
> +		else
> +			dev_err(priv->dev,
> +				"Malformed NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
> +				len, ret);
> +		goto out;

Most of the detailed parser errors are already rate limited inside the
decoder, but this outer message is not.  If firmware repeatedly reports an
unsupported or malformed vendor section, this can still generate one line
per event.

Please make the outer message rate limited as well, or avoid the second
message when the decoder has already emitted a detailed diagnostic.

Thanks.
Shuai
