Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C13630AD
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955272; cv=none; b=IN7g3VEc7tc6r74Yg+DacMIpPwhaH2tpIgA88P9QFmuRMSP4vtEpauQvLc9o4IAa/FRTRFG3UKhdSs1pbw0hdZXQvJiU3Yl2Ocg5l0c+CIxM9Ox4Q4GDpcigTOoYQUrC29kMVStNjaaKPFIIBhPDI8/HL8rt2qjZ6rs8BfUb7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955272; c=relaxed/simple;
	bh=W0rD/cOPgUK28PWYEh1z+yDf9Vj2TEcvXBijPqj3Fls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEENTdlXoN1u9ti5efQmrwm4eWZ4V5IJYSyNANNFFLXJphe0lBKHthgz48Sf/FnP2V7f7gp/Zukyhqoy9/yqeqRTE7yKXvz+xeerZzv1ued6jVJiUIq2ONszOgDumBz/cboaH5i76VMwH8scjvEl18W8mbM/NHdX2gXHT+UmhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2hT92/5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2hT92/5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48541edecf9so67628675e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774955269; x=1775560069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YEkw3ylckLJwXkYeoWI/hbfFZ1Vtar3RpsKaKLUPEM=;
        b=W2hT92/5d/p4ZHkMuUpgQfwO89E6bnF5H/OUjL4J80WjzndTkedVNXqPmij+4AvrDK
         yPp+QrkIjw/+mhiE84uicrz3bFqk8Trkx+Ud3prcErGtAjSI2Hhj6gIdjwP4HACgvAIg
         ZnCK+ucuvV2MGq6Oqmyb/mQf4NPuFjoF9XevNQUWNlLNNkYjIq/S+GqYa7mcL5uejSm4
         Muz7sn3HwwZn88xH6aeml//aourK6F4DUsx/5I2pcMYjeFxuxUwYLBXFndJdnosoyXCc
         9HKSglfHZmC7IdHv1OTFQqWmJY9rcHZC3pilv/NSNCaDZB3GsLIwS3VR02KIne21WTa7
         r3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955269; x=1775560069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YEkw3ylckLJwXkYeoWI/hbfFZ1Vtar3RpsKaKLUPEM=;
        b=IWFq4LHHGvcd+WY3m0vhDGfO+DUmJ43QA38Dpxfzv0gzH6UiXyIrWFAuRBLNnRpaIf
         e+9KbpbACXDzPj1pc/x2MmwZvZSBFF88ABRu71gvkXm/ZWZ3jSy7JU+1tjsqoxzCds1t
         7HbjsKNq7Xfw4HEuVn/wZLtiEgb6D3C1iIZ0wV2L17r9LpT/AJ0Nia5BY3m5mSEUk1j/
         6240iPFlyKKr6voQcVpuIGJg8xkdjRS/0VlnKRU9f0q3l4qbw6yw95TdqdMKgNdhvI9c
         S6zyPL2pmNQ4FuBKthfiZpNlXcKdRcAK79dTq4Z73TrJ0ISklymU5vAdaan5siJIMUWS
         AH3w==
X-Forwarded-Encrypted: i=1; AJvYcCVwbT7ooBUHLrKktmNpTED9fiSDsLUbz5rjqeKCZgpKhF1yVLwr8q74PkljvXzm+lHENYBd/lyXj5F8a7/lkEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9sL3kouWZhYvMs9gz5h1wMOQDxC9Y0qgtRaRXzMmBhlg/+3p
	EcqRc0DWBXuhW3zl4svZjkM+vNlzKgQQ2/jHqJZhOk0txqcS4rsn/+mq
X-Gm-Gg: ATEYQzxYCZdCqK/cRCL0onPgnUG9owIYiJnVrxcAgeXNZ+8iD2FZz8a7A70uZUvHJfE
	AOs9mI3ufyjLSiYjp4aaduqzMZlX6XuFT2LXnglYgZ16psLtTr+6pQP10n5NF8lG6IC4frO6pYt
	0fYxFIADz6Kat6BiMRqbUPmn656lhrpX+exKqxagBCokRYbjpxu+J9nHSkuvl/c6lzJHzU3KjPH
	SiOcyGCgMCi1O2SfsbH36MG/KDaIWcnaN5UrGdUTIEsgk1N0v5wszRC/YZzoUQLhmMJlTjzVrYY
	GLayKQQJ7xw7wYZzwQKCWv7I8O1Nhf+vznCnMbj5ZLOIUI5jbts6+DGZfEGBWx2sGGFh871qcrv
	EPQNBc8C2xR6FY/cPB3A/Ty54K2u7UX4otSBagmEiGw5qurT2cq6UljWjwowQtUsqe21pFq8ClO
	+S55asucNlf8eiXfKKGgahY1VTB6s8iMgmq46mdJd+l+dd8AEwWfZin8ZGcBIaOMmwe7TTivz5F
	K518UDQ/k0hnfw9AAiPYw==
X-Received: by 2002:a05:600c:810b:b0:487:219e:41c with SMTP id 5b1f17b1804b1-48727f36da5mr245388535e9.28.1774955269247;
        Tue, 31 Mar 2026 04:07:49 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8797ecsm26935255e9.8.2026.03.31.04.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 04:07:48 -0700 (PDT)
Message-ID: <37169136-2fa2-4756-b3cc-6049766c8319@gmail.com>
Date: Tue, 31 Mar 2026 12:07:48 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of
 -Wflex-array-members-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <acr7Whmn0br3xeBP@kspp>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <acr7Whmn0br3xeBP@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 11:38 PM, Gustavo A. R. Silva wrote:
> Apparently, struct bpf_empty_prog_array exists entirely to populate a
> single element of "items" in a global variable. "null_prog" is only
> used during the initializer.
> 
> None of this is needed; globals will be correctly sized with an array
> initializer of a flexible-array member.
> 
> So, remove struct bpf_empty_prog_array and adjust the rest of the code,
> accordingly.
> 
> With these changes, fix the following warnings:
> 
> 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
Great cleanup! It was quite confusing how we used null_prog to fill the 
fist element of the flexible array. I wonder why was it done like that.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Changes in v2:
>   - Remove struct bpf_empty_prog_array. (Kees)
> 
> v1:
>   -Link: https://lore.kernel.org/linux-hardening/aaZr2A1UPJq33127@kspp/
> 
>   include/linux/bpf-cgroup.h |  2 +-
>   include/linux/bpf.h        |  7 +------
>   kernel/bpf/core.c          | 12 +++++++-----
>   3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 2f535331f926..b2e79c2b41d5 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -184,7 +184,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   	struct bpf_prog_array *array;
>   
>   	array = rcu_access_pointer(cgrp->bpf.effective[type]);
> -	return array != &bpf_empty_prog_array.hdr;
> +	return array != &bpf_empty_prog_array;
>   }
>   
>   /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..4f5b9e85a20c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2365,18 +2365,13 @@ struct bpf_prog_array {
>   	struct bpf_prog_array_item items[];
>   };
>   
> -struct bpf_empty_prog_array {
> -	struct bpf_prog_array hdr;
> -	struct bpf_prog *null_prog;
> -};
> -
>   /* to avoid allocating empty bpf_prog_array for cgroups that
>    * don't have bpf program attached use one global 'bpf_empty_prog_array'
>    * It will not be modified the caller of bpf_prog_array_alloc()
>    * (since caller requested prog_cnt == 0)
>    * that pointer should be 'freed' by bpf_prog_array_free()
>    */
> -extern struct bpf_empty_prog_array bpf_empty_prog_array;
> +extern struct bpf_prog_array bpf_empty_prog_array;
>   
>   struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
>   void bpf_prog_array_free(struct bpf_prog_array *progs);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 67eb12b637a5..ca39d2e690b9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2613,8 +2613,10 @@ static struct bpf_prog_dummy {
>   	},
>   };
>   
> -struct bpf_empty_prog_array bpf_empty_prog_array = {
> -	.null_prog = NULL,
> +struct bpf_prog_array bpf_empty_prog_array = {
> +	.items = {
> +		{ .prog = NULL },
> +	},
>   };
>   EXPORT_SYMBOL(bpf_empty_prog_array);
>   
> @@ -2625,14 +2627,14 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
>   	if (prog_cnt)
>   		p = kzalloc_flex(*p, items, prog_cnt + 1, flags);
>   	else
> -		p = &bpf_empty_prog_array.hdr;
> +		p = &bpf_empty_prog_array;
>   
>   	return p;
>   }
>   
>   void bpf_prog_array_free(struct bpf_prog_array *progs)
>   {
> -	if (!progs || progs == &bpf_empty_prog_array.hdr)
> +	if (!progs || progs == &bpf_empty_prog_array)
>   		return;
>   	kfree_rcu(progs, rcu);
>   }
> @@ -2653,7 +2655,7 @@ static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
>   
>   void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
>   {
> -	if (!progs || progs == &bpf_empty_prog_array.hdr)
> +	if (!progs || progs == &bpf_empty_prog_array)
>   		return;
>   	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
>   }

