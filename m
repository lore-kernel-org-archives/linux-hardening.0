Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39FD520;
	Sat,  8 Jun 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838366; cv=none; b=OTVEnetXA2c5JGKXxIlnnqUm+F3p/+jRPVGZPmTh8NPST656dST1NfTiLhg+vP7dw61mfubJkpwJM3XooF1LY9YRAPO7ihS+VWa9kFS5i+IdUd7rXx2AqKznmZ/TIJCwGW78cJ1txK+8XZ8Ge7JB1wcrkzYK2s8dDIuMdbI7bhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838366; c=relaxed/simple;
	bh=JXCgkp8fnP+d/k+04ZlhBAOZdx7wDVBWM9WI6Qhiy0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR4WEkHqGyhGUib7L1umqEMWzcalkDJ61BIsbBkf6EA1D4muSzhYPV4Md1ljREPJ0sc1JGe5QGzxUMBqAX2zBGDxLmakpPpfhjJ6Zpm+ZlVU+r2rHPzor0cope+1Z8r5cd/EmbDaL7d26KzhM/FuMBMK0oFL2auCjjBFp1N2mvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ca3l9mwM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ca3l9mwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6153BC2BD11;
	Sat,  8 Jun 2024 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717838366;
	bh=JXCgkp8fnP+d/k+04ZlhBAOZdx7wDVBWM9WI6Qhiy0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ca3l9mwMEkAhZGDLkIxfpPCHALgECioQhNNOtNT7f5PHU1J+r3Wlj3x1MKbv6xKOx
	 0CP/Y0R1xXvNdk7ctHPsgAC/URw30AEN6TIE7RWVhvFuhgM2XoBfN5wWU0xKuggFwv
	 HCHFL9S33atlteica5gvA6o2UkbVCfCoKmbTA7Ls=
Date: Sat, 8 Jun 2024 11:19:21 +0200
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
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <2024060812-setting-unveiling-527f@gregkh>
References: <20240607122622.167228-1-coxu@redhat.com>
 <20240607122622.167228-3-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-3-coxu@redhat.com>

On Fri, Jun 07, 2024 at 08:26:12PM +0800, Coiby Xu wrote:
> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to
> make the dm crypt keys persist for the kdump kernel. Take the case of
> dumping to a LUKS-encrypted target as an example, here is the life cycle
> of this kdump copy of LUKS volume keys,
> 
>  1. After the 1st kernel loads the initramfs during boot, systemd
>     use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>     volume keys and then save the volume keys to specified keyring
>     (using the --link-vk-to-keyring API) and the key will expire within
>     specified time.
> 
>  2. A user space tool (kdump initramfs builder) writes a key description to
>     /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
>     key while building the kdump initramfs
> 
>  3. The kexec_file_load syscall read the volume keys by recorded key
>     descriptions and then save them key to kdump reserved memory and wipe the
>     copy.
> 
>  4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>     initramfs asks the kdump kernel to create a user key using the key stored in
>     kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
>     the LUKS encrypted devide is unlocked with libcryptsetup's
>     --volume-key-keyring API.
> 
>  5. The system gets rebooted to the 1st kernel after dumping vmcore to
>     the LUKS encrypted device is finished
> 
> I assume 1) there are 128 LUKS devices at maximum to be unlocked thus
> MAX_KEY_NUM=128 2) and a key won't exceed 256 bytes thus
> MAX_KEY_SIZE=256 according to "cryptsetup benchmark".
> 
> For details on usage of the API, please check the new doc file
> Documentation/ABI/testing/crash_dm_crypt_keys.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  Documentation/ABI/testing/crash_dm_crypt_keys |  30 ++++
>  include/linux/crash_core.h                    |   5 +-
>  kernel/Kconfig.kexec                          |   9 ++
>  kernel/Makefile                               |   1 +
>  kernel/crash_dump_dm_crypt.c                  | 130 ++++++++++++++++++
>  kernel/ksysfs.c                               |  24 ++++
>  6 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/crash_dm_crypt_keys
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> diff --git a/Documentation/ABI/testing/crash_dm_crypt_keys b/Documentation/ABI/testing/crash_dm_crypt_keys
> new file mode 100644
> index 000000000000..e6a6f6be5a9e
> --- /dev/null
> +++ b/Documentation/ABI/testing/crash_dm_crypt_keys
> @@ -0,0 +1,30 @@
> +What:		/sys/kernel/crash_dm_crypt_keys
> +Date:		Jun 2024
> +KernelVersion:	6.11
> +Contact:	kexec@lists.infradead.org
> +Description:	read/write
> +    Make dm crypt keys persistent for the kdump kernel.

Tabs please.

> +
> +    Assume the key size won't exceed 256 bytes and the maximum number of keys is 128.

Please wrap the documentation lines.

And who makes this assumption?  The kernel?  Userspace?  Something else?
Who enforces it?  What happens if it is not true?

> +
> +    You can write the following commands before kexec'ing the kdump kernel,
> +      - "init KEY_NUM"
> +        Let the kernel know the number of dm crypt keys so it will initialize
> +        needed structures. KEY_NUM=128 dm crypt keys at maximum.
> +        - "record KEY_DESC"
> +        Record a key description. For security reason, the key must be a logon
> +        key whose payload can't be read by user space. For details, please refer
> +        to security/keys/core.rst.
> +
> +    And you can also read this API to know the command eructation status,
> +      - fresh
> +        Waiting for a command
> +      - initialized
> +        The "init KEY_NUM" command has been executed successfully
> +      - recorded
> +        Specified number of keys have been recorded
> +      - loaded
> +        the kdump kernel has been loaded with the dm crypt keys stored to kdump
> +        reserved memory

I do not understand, this is a command that you write to this file?
That's not how sysfs files work at all.

And this isn't really very well documented, I do not understand if this
is read/write or just read or just write or a mix?  And what are the
valid write values?  Valid read?  Why "init" vs. "initialized"?



> +
> +User:		Kdump service
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

No versions for when this is not enabled?

>  
>  #ifndef arch_crash_handle_hotplug_event
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..d067ba252163 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -116,6 +116,15 @@ config CRASH_DUMP
>  	  For s390, this option also enables zfcpdump.
>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  
> +config CRASH_DM_CRYPT
> +	bool "Support saving crash dump to dm-crypt encrypted volume"
> +	depends on CRASH_DUMP
> +	depends on DM_CRYPT
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
> index 000000000000..608bde3aaa8e
> --- /dev/null
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <keys/user-type.h>
> +#include <linux/crash_dump.h>
> +
> +#define KEY_NUM_MAX 128   /* maximum dm crypt keys */
> +#define KEY_SIZE_MAX 256  /* maximum dm crypt key size */

Tabs please.


> +
> +// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
> +#define KEY_DESC_LEN 48

"scription"?  And is this a string length?  Why not use the in-kernel
uuid code if you are dealing with uuid values?

> +
> +static enum STATE_ENUM {
> +	FRESH = 0,
> +	INITIALIZED,
> +	RECORDED,
> +	LOADED,
> +} state;
> +
> +static const char * const STATE_STR[] = {
> +	[FRESH] = "fresh",
> +	[INITIALIZED] = "initialized",
> +	[RECORDED] = "recorded",
> +	[LOADED] = "loaded"
> +};
> +
> +static unsigned int key_count;
> +static size_t keys_header_size;

So all of the keys have a single header size?

> +
> +struct dm_crypt_key {
> +	unsigned int key_size;
> +	char key_desc[KEY_DESC_LEN];
> +	u8 data[KEY_SIZE_MAX];
> +};
> +
> +static struct keys_header {
> +	unsigned int total_keys;
> +	struct dm_crypt_key keys[] __counted_by(total_keys);
> +} *keys_header;
> +
> +static size_t get_keys_header_size(struct keys_header *keys_header,
> +				   size_t total_keys)
> +{
> +	return struct_size(keys_header, keys, total_keys);
> +}
> +
> +/*
> + * Let the kernel know the number of dm crypt keys and allocate memory to
> + * initialize related structures.
> + */
> +static int init(const char *buf)
> +{
> +	unsigned int total_keys;
> +
> +	if (sscanf(buf, "init %u", &total_keys) != 1)
> +		return -EINVAL;
> +
> +	if (total_keys > KEY_NUM_MAX) {
> +		kexec_dprintk(
> +			"Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
> +			KEY_NUM_MAX);
> +		return -EINVAL;
> +	}
> +
> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
> +	key_count = 0;
> +
> +	if (keys_header != NULL)
> +		kvfree(keys_header);
> +
> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
> +	if (!keys_header)
> +		return -ENOMEM;
> +
> +	keys_header->total_keys = total_keys;
> +	state = INITIALIZED;
> +	return 0;
> +}
> +
> +/*
> + * Record the key description of a dm crypt key.
> + */
> +static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
> +{
> +	char key_desc[KEY_DESC_LEN];
> +
> +	if (state != INITIALIZED) {
> +		kexec_dprintk("Please send the cmd 'init <KEY_NUM>' first\n");
> +		return -EINVAL;
> +	}
> +
> +	if (sscanf(buf, "record %s", key_desc) != 1)
> +		return -EINVAL;
> +
> +	if (key_count >= keys_header->total_keys) {
> +		kexec_dprintk("Already have %u keys", key_count);
> +		return -EINVAL;
> +	}
> +
> +	strscpy(dm_key->key_desc, key_desc, KEY_DESC_LEN);
> +	kexec_dprintk("Key%d (%s) recorded\n", key_count, dm_key->key_desc);
> +	key_count++;
> +
> +	if (key_count == keys_header->total_keys)
> +		state = RECORDED;
> +
> +	return 0;
> +}
> +
> +static int process_cmd(const char *buf, size_t count)
> +{
> +	if (strncmp(buf, "init ", 5) == 0)
> +		return init(buf);
> +	else if (strncmp(buf, "record ", 7) == 0 && count == KEY_DESC_LEN + 6)
> +		return record_key_desc(buf, &keys_header->keys[key_count]);

So you are parsing the "init" and "record" strings twice?  That feels
wrong, and might get out of sync easily.

But again, having a sysfs file that does "actions" like this is odd too,
as you have multiple things in the same string.  sysfs is "one value per
file", why aren't you using configfs instead?  That's meant for
configuring stuff, not sysfs.


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
> +EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_write);
> +
> +int crash_sysfs_dm_crypt_keys_read(char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", STATE_STR[state]);
> +}
> +EXPORT_SYMBOL_GPL(crash_sysfs_dm_crypt_keys_read);
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 07fb5987b42b..ff7caef30f51 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -167,6 +167,27 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
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
> +	if (ret < 0)
> +		return ret;
> +	return count;

Why doesn't crash_sysfs_dm_crypt_keys_write just return the count value
processed?  No need to check the return value again.

thanks

greg k-h
