Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D013C677;
	Thu, 23 May 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448872; cv=none; b=kqfK8HKVN1pO9eC3G79WVNjtn78B02UtnUlqmLLaCiRQKDBfhjtfKoVREIIdxxuC2338S+aAsk1B/JI8m499JZ7GoZgiistkVglAKNVRTkbTwxnC52D7MDgC7IGE4i3FasqqzYa8OXTa8cjvXDeqqLLchr1RKJUEaG8iBRGN/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448872; c=relaxed/simple;
	bh=Y7gZu5bqG/ecW5fDqIWGY+8x/ZkP3+KZzibwYtNBZxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN+n/EDEPckCjr9sYvxvMzv69INOijmn9OT7W68pinx/NXZQxEWbiMckWr/CpAC8MaGwi/xgcxgMXuq+0fMoe+Uyd6ZrBatZxFCH9ImAag4KTn0hf5OqG5yE4c+FjhPPLZvLNnd7k4eAr8Ze7CISiTPkFZgylFov4Fuq9sJDPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iT//pMv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iT//pMv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1569AC2BD10;
	Thu, 23 May 2024 07:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716448871;
	bh=Y7gZu5bqG/ecW5fDqIWGY+8x/ZkP3+KZzibwYtNBZxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iT//pMv+kpdtHILAxQt4By4QWfUoOE7Kw84GrAc+sMjN5bCCHBP1VgLWpL5QQQtXp
	 /GdzONRctkqgv1HeBpsq+KBXBakCwMVdeQ603tYbAOjJ16XxFn1wEbzaBDgGsBTPkd
	 NjunMpvXLvdMbHIIWkbo9SHydjY0dUr2Jo/Lgv1s=
Date: Thu, 23 May 2024 09:21:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <2024052334-protegee-cheating-5934@gregkh>
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

On Thu, May 23, 2024 at 01:04:43PM +0800, Coiby Xu wrote:
> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
> the dm crypt keys persist for the kdump kernel. User space can send the
> following commands,
> - "init KEY_NUM"
>   Initialize needed structures
> - "record KEY_DESC"
>   Record a key description. The key must be a logon key.

"logon"?  What is that?

> 
> User space can also read this API to learn about current state.

But you don't document it in Documentation/ABI/ so we don't know if this
really is the case, and no one will know how to use it :(

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

Why these values?

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

How are you going to keep these enums synced up with the string values?

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

Why 5?

> +
> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)

Didn't you just overflow dummy now?

> +		return -EINVAL;
> +
> +	if (key_count > KEY_NUM_MAX) {
> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
> +		       KEY_NUM_MAX);

Do not let userspace spam the kernel log directly if it sends it invalid
data.

> +		return -EINVAL;
> +	}
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
> +
> +static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
> +{
> +	char key_desc[KEY_DESC_LEN];
> +	char dummy[7];
> +
> +	if (state != INITIALIZED)
> +		pr_err("Please send the cmd 'init <KEY_NUM>' first\n");

Again, don't let userspace spam the log.

> +
> +	if (sscanf(buf, "%6s %s", dummy, key_desc) != 2)
> +		return -EINVAL;
> +
> +	if (key_count >= keys_header->key_count) {
> +		pr_warn("Already have %u keys", key_count);
> +		return -EINVAL;
> +	}
> +
> +	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
> +	pr_debug("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
> +	key_count++;
> +
> +	if (key_count == keys_header->key_count)
> +		state = RECORDED;
> +
> +	return 0;
> +}
> +
> +static int process_cmd(const char *buf, size_t count)
> +{
> +	if (strncmp(buf, "init ", 5) == 0)
> +		return init(buf);
> +	else if (strncmp(buf, "record ", 7) == 0)
> +		return record_key_desc(buf, &keys_header->keys[key_count]);
> +
> +	return -EINVAL;
> +}
> +
> +int crash_sysfs_dm_crypt_keys_write(const char *buf, size_t count)
> +{
> +	if (!is_kdump_kernel())
> +		return process_cmd(buf, count);
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);

EXPORT_SYMBOL_GPL() as you are dealing with a sysfs api?


> +
> +int crash_sysfs_dm_crypt_keys_read(char *buf)
> +{
> +	return sprintf(buf, "%s\n", STATE_STR[state]);

sysfs_emit() please.

> +}
> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);

Again, EXPORT_SYMBOL_GPL()?

> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 07fb5987b42b..2ba4dcbf5816 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -167,6 +167,25 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>  }
>  KERNEL_ATTR_RO(vmcoreinfo);
>  
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +static ssize_t crash_dm_crypt_keys_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	return crash_sysfs_dm_crypt_keys_read(buf);
> +}
> +
> +static ssize_t crash_dm_crypt_keys_store(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	int ret;
> +
> +	ret = crash_sysfs_dm_crypt_keys_write(buf, count);
> +	return ret < 0 ? ret : count;

Personally, I hate ? : lines, just write it out, the compiler is the
same and this way it is much more readable:
	if (ret < 0)
		return ret;
	return count;

thanks,

greg k-h
