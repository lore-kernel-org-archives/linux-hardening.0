Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E622EE9
	for <linux-hardening@vger.kernel.org>; Sat, 25 May 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716628807; cv=none; b=C2t4IfI2K+T7D8akDPK7VU52+OO/QCVmej94e5JFu0EKbd/NTCLszBzQfbz764FRZKjW8qAZiTzEqaOooOcX1TP9+NlB2nA3q6JjezYPtjpH1anOPhf3bRMiMF6WuIx/V27mkXbFxXQp/UJYvyWNYfXi5y3MWtYB0js7HQsfhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716628807; c=relaxed/simple;
	bh=rSskSPVxXy5Ck8nOMqazWrp8/0K12tTA04uoMov5tYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XIy8XeymOwyiUNCOyXSCxJ3hU082TakSxHoSgxFkGDdanKKU7Q7UGkJW0z7zpUwjOqXJaumxf78LNmI2ELyELyR5cMWKyAbK0M99EJWWcmhAwt5wDIyvRloHT5noSuyRTmqcamDeFy4TQW0usuQYsyY9/5+jl7+keyiSp8l7Q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSno1z+e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSno1z+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716628805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eASqbe6YEnizYGq/4R2maOLvkAhSwYCyttDAYwLxidw=;
	b=MSno1z+etbyydBNUq3h/pHThN1KC9AxUYz5g8ut3nRyP8CQhJi1T87JfOrlVpkDRzkawzK
	jEeGK4t0RPZIRHOU14nDvqPneFC5/7h4LgGONYY/8Imzpd1ckt1wxJXG0ImtXQPbrzrGwG
	c+gyeAGs9epV5eLs2aXetaQ0NQoRpOU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-QZK_CZ4UOkOjKFbNAmU3uQ-1; Sat, 25 May 2024 05:20:03 -0400
X-MC-Unique: QZK_CZ4UOkOjKFbNAmU3uQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6f105fabe43so3221600a34.0
        for <linux-hardening@vger.kernel.org>; Sat, 25 May 2024 02:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716628802; x=1717233602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eASqbe6YEnizYGq/4R2maOLvkAhSwYCyttDAYwLxidw=;
        b=DNUuEgByLh4z8AAenByNw7zzHdyy8gU1wonNXvBIRFtALKk/nRXc1GnooliMJL9U2j
         I6/B2N3TxJIw+ZOqkK+JX8pFcA988EDHHJgxJvVISxZey/Rtk7VGHGi3vyUH3gZyiJh4
         4nNa5eV+GuKZLOzX/0Am+kfdW1CiH3YAEdpjn1bE9FUIgAL6flk2Z0wVUh/flJkeSBng
         TnHAo5ZTQrpN6e5FYv39dqq5MR8qK5JiJedL9+n3QwmrEhD2kKEAadgNiAPGN1PsGNZl
         JIxGOPP/H3ISUoqkb6vFQYCby10CGkknTtacbNQ7sgdPMscTk2zHllI1iSqbKv1ld+tY
         ttqg==
X-Forwarded-Encrypted: i=1; AJvYcCV2YoEMPTYaI9wT/+Rix9lCeHxdUdUaKvKpD1mzvLo/MoPmnI4ZA7V/CljsKwHEMLHiqI/NyVsTPN+MiKlhstgzmThX5zPu3n9W8vuTyjoL
X-Gm-Message-State: AOJu0YxRDnPTKqnnG4d83HmHya/z62xHwLBndTSFjv6hHSaEmOz3stUr
	AelXjyo46OsvwCtoqAMzeX/LAGMinCWeQROHsXN72op1/13dHOPTxvVE1S1XUeitMo4cqZ44pxz
	O+8QCV/L4Iv7dICVmYGy7PlDuYvwn5EY3R0zAiMsrKFs+9UNhMKQBY330s0oyvOZWZw==
X-Received: by 2002:a05:6870:e256:b0:24e:e931:8f1f with SMTP id 586e51a60fabf-24eeabe4ba2mr2693912fac.33.1716628802279;
        Sat, 25 May 2024 02:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzgl+mXOrooOjhH2kofClUmgOiLg6jxvqb743JJExXOnyiKvQ1laCvo2ODxkHeVivV9qCPSQ==
X-Received: by 2002:a05:6870:e256:b0:24e:e931:8f1f with SMTP id 586e51a60fabf-24eeabe4ba2mr2693887fac.33.1716628801735;
        Sat, 25 May 2024 02:20:01 -0700 (PDT)
Received: from localhost ([2409:8924:81b:1d01:5bbd:6e70:ff5b:4ece])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb5dfsm2160624b3a.123.2024.05.25.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 02:20:01 -0700 (PDT)
Date: Sat, 25 May 2024 15:57:20 +0800
From: Coiby Xu <coxu@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <tybsp5qrjf25mlj5zrzfg5lhzykmz4ztzrmqv4tntbfypca5oa@2zfjjdxblvft>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-3-coxu@redhat.com>
 <2024052334-protegee-cheating-5934@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024052334-protegee-cheating-5934@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Greg,

Thanks for taking time to carefully review this patch!

On Thu, May 23, 2024 at 09:21:08AM +0200, Greg KH wrote:
>On Thu, May 23, 2024 at 01:04:43PM +0800, Coiby Xu wrote:
>> A sysfs /sys/kernel/crash_dm_crypt_keys is provided for user space to make
>> the dm crypt keys persist for the kdump kernel. User space can send the
>> following commands,
>> - "init KEY_NUM"
>>   Initialize needed structures
>> - "record KEY_DESC"
>>   Record a key description. The key must be a logon key.
>
>"logon"?  What is that?

Thanks for raising this question. A logon key is similar to a user key
but the payload can't be read by user space. I'll document this info and
also refer users to security/keys/core.rst for details.

>
>>
>> User space can also read this API to learn about current state.
>
>But you don't document it in Documentation/ABI/ so we don't know if this
>really is the case, and no one will know how to use it :(

Thanks for bringing this to my attention! A new version will include
Documentation/ABI/testing/crash_dm_crypt_keys to have all the details. 

>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/crash_core.h   |   5 +-
>>  kernel/Kconfig.kexec         |   8 +++
>>  kernel/Makefile              |   1 +
>>  kernel/crash_dump_dm_crypt.c | 113 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  22 +++++++
>>  5 files changed, 148 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
[...]
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> new file mode 100644
>> index 000000000000..78809189084a
>> --- /dev/null
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <keys/user-type.h>
>> +#include <linux/crash_dump.h>
>> +
>> +#define KEY_NUM_MAX 128
>> +#define KEY_SIZE_MAX 256
>
>Why these values?

For KEY_NUM_MAX, I assume the maximum number of LUKS encrypted volumes to
unlock is 128. 

For KEY_SIZE_MAX, according to /proc/crypto and "cryptsetup benchmark",
the maximum key size is 64 bytes. So I assume 256 should be enough in
near future.

Thanks for raising the question which makes realize it's better to
include the assumptions in the commit message for domain experts to
examine!

>
>> +
>> +// The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>> +#define KEY_DESC_LEN 48
>> +
>> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
>> +static enum STATE_ENUM {
>> +	FRESH = 0,
>> +	INITIALIZED,
>> +	RECORDED,
>> +	LOADED,
>> +} state;
>
>How are you going to keep these enums synced up with the string values?

Thanks to prompt me to come up with a more reliable way! I should have
used the emums to index the array,

static const char *STATE_STR[] = {
     [FRESH] = "fresh",
     [INITIALIZED] = "initialized",
     [RECORDED] = "recorded",
     [LOADED] = "loaded"
};

>
>> +
>> +static unsigned int key_count;
>> +static size_t keys_header_size;
>> +
>> +struct dm_crypt_key {
>> +	unsigned int key_size;
>> +	char key_desc[KEY_DESC_LEN];
>> +	u8 data[KEY_SIZE_MAX];
>> +};
>> +
>> +static struct keys_header {
>> +	unsigned int key_count;
>> +	struct dm_crypt_key keys[] __counted_by(key_count);
>> +} *keys_header;
>> +
>> +static size_t get_keys_header_size(struct keys_header *keys_header,
>> +				   size_t key_count)
>> +{
>> +	return struct_size(keys_header, keys, key_count);
>> +}
>> +
>> +static int init(const char *buf)
>> +{
>> +	unsigned int total_keys;
>> +	char dummy[5];
>
>Why 5?

Oh, I had len("init")+1(NULL) in mind when wrote 5. In retrospect, 5
is not necessary. And in fact there is no need to define this dummy
variable in the first place as explained in the next comment.

>
>> +
>> +	if (sscanf(buf, "%4s %u", dummy, &total_keys) != 2)
>
>Didn't you just overflow dummy now?

Correct me if I'm wrong, but using the width specifier i.e. "%4s" won't
overflow dummy, right? Anyways, I think a better way is to simply use
sscanf(buf, "init %u",..)
instead thus no need for this dummy variable.

>
>> +		return -EINVAL;
>> +
>> +	if (key_count > KEY_NUM_MAX) {
>> +		pr_err("Exceed the maximum number of keys (KEY_NUM_MAX=%u)\n",
>> +		       KEY_NUM_MAX);
>
>Do not let userspace spam the kernel log directly if it sends it invalid
>data.

Thanks for pointing out my oversight. I'll simply return -EINVAL in next
version.

>
>> +		return -EINVAL;
>> +	}
>> +
>> +	keys_header_size = get_keys_header_size(keys_header, total_keys);
>> +	key_count = 0;
>> +
>> +	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>> +	if (!keys_header)
>> +		return -ENOMEM;
>> +
>> +	keys_header->key_count = total_keys;
>> +	state = INITIALIZED;
>> +	return 0;
>> +}
>> +
>> +static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
>> +{
>> +	char key_desc[KEY_DESC_LEN];
>> +	char dummy[7];
>> +
>> +	if (state != INITIALIZED)
>> +		pr_err("Please send the cmd 'init <KEY_NUM>' first\n");
>
>Again, don't let userspace spam the log.

I'll fix this issue in next version. Thank you again!

>
>> +
>> +	if (sscanf(buf, "%6s %s", dummy, key_desc) != 2)

Oh, key_desc could be overflowed here if there is a malicious user. I'll
have a check on the length of buf in next version.


[...]
>> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_write);
>
>EXPORT_SYMBOL_GPL() as you are dealing with a sysfs api?

>
>> +int crash_sysfs_dm_crypt_keys_read(char *buf)
>> +{
>> +	return sprintf(buf, "%s\n", STATE_STR[state]);
>
>sysfs_emit() please.

This will be fixed, thanks!

>
>> +}
>> +EXPORT_SYMBOL(crash_sysfs_dm_crypt_keys_read);
>
>Again, EXPORT_SYMBOL_GPL()?

I'll replace two occurrences of EXPORT_SYMBOL with EXPORT_SYMBOL_GPL,
thanks!

>
>> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
>> index 07fb5987b42b..2ba4dcbf5816 100644
>> --- a/kernel/ksysfs.c
>> +++ b/kernel/ksysfs.c
>> @@ -167,6 +167,25 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>>  }
>>  KERNEL_ATTR_RO(vmcoreinfo);
>>
>> +#ifdef CONFIG_CRASH_DM_CRYPT
>> +static ssize_t crash_dm_crypt_keys_show(struct kobject *kobj,
>> +					struct kobj_attribute *attr, char *buf)
>> +{
>> +	return crash_sysfs_dm_crypt_keys_read(buf);
>> +}
>> +
>> +static ssize_t crash_dm_crypt_keys_store(struct kobject *kobj,
>> +					 struct kobj_attribute *attr,
>> +					 const char *buf, size_t count)
>> +{
>> +	int ret;
>> +
>> +	ret = crash_sysfs_dm_crypt_keys_write(buf, count);
>> +	return ret < 0 ? ret : count;
>
>Personally, I hate ? : lines, just write it out, the compiler is the
>same and this way it is much more readable:
>	if (ret < 0)
>		return ret;
>	return count;

Thanks for suggesting more readable code! I'll apply it to next version!


>
>thanks,
>
>greg k-h
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby

