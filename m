Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363B19006E
	for <linux-hardening@vger.kernel.org>; Wed,  5 Jun 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575747; cv=none; b=OrYFas0cv0H8GC1KnfOkBU5bgvaqR+qUQGhwTTSYflCS6+S9oPJwP0QqxvgSHHembW1r5Q8pKoTpTQ2ds2KCjAaaRVoLhoq+pDbVDX8IzSqZ7ZksYSeNQaukWCWL5e6DNbyPU7JlVD95TPwQewbOi7Fp5NbuWRt95SePFhC7Q8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575747; c=relaxed/simple;
	bh=r08FZZCbb4PqL2wKVDhzXY2U1+vU+mtMPQ8v9bt1+Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKvRLkyUPIy9aF3AKrl4BB1BgW+NZFww2/Kk1DHcaKIXOcD8r8qZrnojwwG6q1oh6F8Wmpq8uLCd6FfQg4jMnpKlAius8iCnw0In7IEodMgvIZuC7ofQPGaMPUmQP8u6sVuP5pTT4IGZFZ1O1jzhAJxrd1pO7L9k5CmQm5FJZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pf9EOmbr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf9EOmbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BN2s5RkmRwWRATVy8iKU5IoEWdjTC3uEaBsPoMrm1Tw=;
	b=Pf9EOmbr739OWnrK0ELw34gwZnTb/stZt4WKOMZQK6OUWcUqD06kV4v0CiSiJ4pxYWPL6m
	D1HMGePWit2J5xDLv7Z7ySRxBjHbk31FlKVxIS1Wg7K9fsl3XYfMeAizZCc3RnnWhCCrPi
	WL8luD7mhteuknRJ6KAiRn1u9ZXJBGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-VB7HM_AlMjizRozuDTrOFQ-1; Wed, 05 Jun 2024 04:22:17 -0400
X-MC-Unique: VB7HM_AlMjizRozuDTrOFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0112F101A520;
	Wed,  5 Jun 2024 08:22:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 10CF6202A438;
	Wed,  5 Jun 2024 08:22:15 +0000 (UTC)
Date: Wed, 5 Jun 2024 16:22:12 +0800
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
Message-ID: <ZmAgNIXXa32Bv/Of@MiWiFi-R3L-srv>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 05/23/24 at 01:04pm, Coiby Xu wrote:
.....
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

These two global variables seems not so necessary. Please see comment at
below.

> +
> +struct dm_crypt_key {
> +	unsigned int key_size;
> +	char key_desc[KEY_DESC_LEN];
> +	u8 data[KEY_SIZE_MAX];
> +};
> +
> +static struct keys_header {
> +	unsigned int key_count;
                     ~~~~~~~~
                     This is the max number a system have from init();
You can add one field member to record how many key slots have been
used.
> +	struct dm_crypt_key keys[] __counted_by(key_count);
> +} *keys_header;

Maybe we can rearrange the keys_header like below, the name may not be
very appropriate though.

static struct keys_header {
	unsigned int max_key_slots;
	unsigned int used_key_slots;
	struct dm_crypt_key keys[] __counted_by(key_count);
} *keys_header;

>

> +
> +static size_t get_keys_header_size(struct keys_header *keys_header,
> +				   size_t key_count)
> +{
> +	return struct_size(keys_header, keys, key_count);
> +}

I personally don't think get_keys_header_size is so necessary. If we
have to keep it, may be we can remove the global variable
keys_header_size, we can call get_keys_header_size() and use local
variable to record the value instead.

