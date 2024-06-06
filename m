Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8981BDD5
	for <linux-hardening@vger.kernel.org>; Thu,  6 Jun 2024 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643502; cv=none; b=uouw81iKPwb+izgTJ4cW/+tlOIoA0XqZgt8KYcd5b/+u2z7WOd2Qf3g5sDX7dYAJRp99ofQ/StV3+LEQhINnFoQ7Z6M6pmig4lUKqtXibCIDXYDfGOzbDTunBLN3oaUxH+z3ZrXejhO6uzYGhQ/JChTttdS4Th5Xabo2zE76Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643502; c=relaxed/simple;
	bh=1+v65+8xW4kXOQvfyRKPcvYScMtAHUdktuXv4AiUvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1WdH0B/drRi29QRaMeDST9c4kG+M1GX6XHvRekRrn6MoLd/+j7uFNAQW0RSyBh8pnmsOdal8+HKkP315aJlgMLcFBmWsDil8qgCjbDLeVyqdhdXP0aW4dxyHqK7PqA5hbLpcxCLPXZjzjZ9G1xAbauqE+pFxaF9uT0KvrGDsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuNuOQSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuNuOQSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717643498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaH59veb3gdb6Nle+VT8H76NeiKE5kPsBGNNkDgKop8=;
	b=CuNuOQSqDoadSCobdsW2jB+1gXT68g+mQLqSfbYsZU7xaHjX55JyBkkW96mTtDzM/MxmhN
	rpU0AEZj02WnXZWhr7CZRbCLaByTUxVh7jt+RQoqmIsYg+4WAvDkK3YHpVi+rI1I53knTM
	NXEIoaaLl4FuIjsyO/NyOeE/7UtjPEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-kezD0FAoPNayyhfCPlTgHA-1; Wed, 05 Jun 2024 23:11:35 -0400
X-MC-Unique: kezD0FAoPNayyhfCPlTgHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A280F101A520;
	Thu,  6 Jun 2024 03:11:34 +0000 (UTC)
Received: from localhost (unknown [10.72.113.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B5537D6;
	Thu,  6 Jun 2024 03:11:33 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:11:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <ZmEo4rw8Yhu7tspb@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-3-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
> the dm crypt keys persist for the kdump kernel. User space can send the
> following commands,
> - "init KEY_NUM"
>   Initialize needed structures
> - "record KEY_DESC"
>   Record a key description. The key must be a logon key.

This patch highly lack document to describe what it's doing. For
example, how you will manipulate the /sys/kernel/crash_dm_crypt_keys to
initialize, record the keys, can you give examples how you opeate on
them?

> 
> User space can also read this API to learn about current state.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/crash_core.h   |   5 +-
>  kernel/Kconfig.kexec         |   8 +++
>  kernel/Makefile              |   1 +
>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>  kernel/ksysfs.c              |  22 +++++++
>  5 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 44305336314e..6bff1c24efa3 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -34,7 +34,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
>  static inline void arch_kexec_unprotect_crashkres(void) { }
>  #endif
>  
> -
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +int crash_sysfs_dm_crypt_keys_read(char *buf);
> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count);
> +#endif
>  
>  #ifndef arch_crash_handle_hotplug_event
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..88525ad1c80a 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -116,6 +116,14 @@ config CRASH_DUMP
>  	  For s390, this option also enables zfcpdump.
>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  
> +config CRASH_DM_CRYPT
> +	bool "Support saving crash dump to dm-crypt encrypted volume"
> +	depends on CRASH_DUMP

Do we need add dependency on some security features, e.g KEYS?
The current code will enable the CRASH_DM_CRYPT regardless of the
existence of LUKS disk at all.

> +	help
> +	  With this option enabled, user space can intereact with
> +	  /sys/kernel/crash_dm_crypt_keys to make the dm crypt keys
> +	  persistent for the crash dump kernel.
> +
>  config CRASH_HOTPLUG
>  	bool "Update the crash elfcorehdr on system configuration changes"
>  	default y
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 3c13240dfc9f..f2e5b3e86d12 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
>  obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
>  obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
>  obj-$(CONFIG_CRASH_DUMP) += crash_core.o
> +obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
>  obj-$(CONFIG_KEXEC) += kexec.o
>  obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
>  obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> new file mode 100644
> index 000000000000..78809189084a
> --- /dev/null
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <keys/user-type.h>
> +#include <linux/crash_dump.h>
> +
> +#define KEY_NUM_MAX 128
> +#define KEY_SIZE_MAX 256
> +
> +// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
> +#define KEY_DESC_LEN 48
> +
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static enum STATE_ENUM {
> +	FRESH = 0,
> +	INITIALIZED,
> +	RECORDED,
> +	LOADED,
> +} state;
> +
> +static unsigned int key_count;
> +static size_t keys_header_size;
> +
> +struct dm_crypt_key {
> +	unsigned int key_size;
> +	char key_desc[KEY_DESC_LEN];
> +	u8 data[KEY_SIZE_MAX];
> +};
> +
> +static struct keys_header {
> +	unsigned int key_count;
> +	struct dm_crypt_key keys[] __counted_by(key_count);
> +} *keys_header;
> +
> +static size_t get_keys_header_size(struct keys_header *keys_header,
> +				   size_t key_count)
> +{
> +	return struct_size(keys_header, keys, key_count);
> +}
> +
> +static int init(const char *buf)
> +{
> +	unsigned int total_keys;
> +	char dummy[5];
> +
> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
> +		return -EINVAL;

This is what I wondered and tried to find a document to get why. Can we
search in the current system and deduce how many keys we can could use
for kdump kernel? Or we have to retrieve and pass it from user space?

> +
> +	if (key_count > KEY_NUM_MAX) {
> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
> +		       KEY_NUM_MAX);
> +		return -EINVAL;
> +	}

Why chekcing key_count in init()? Don't you need to check
total_keys instead? Clearly you don't do a boundary test for total_keys,
otherwise it will trigger issue.

> +
> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
> +	key_count = 0;
> +
> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header)
> +		return -ENOMEM;
> +
> +	keys_header->key_count = total_keys;
> +	state = INITIALIZED;
> +	return 0;
> +}

Please add more code comments, kernel-doc for your code, we can't assume
people reading these codes know the entire matter.

