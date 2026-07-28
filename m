Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555E46AEFA
	for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265096; cv=none; b=Wos8hov4fOzEYzqkrKLLopsE9BLyPpYc1Nz2UwIWnDKuOuMbBuJHknUjtD2iuMuDnijQv0E9k5yGzLVycZbiQcigCOxjWvqnctYJ5r35qjyNKgv9Rgrq4VLHLVZ4mkOaGnxrYblavUUMn5AN97xYq+lgPN1dk5zdf8aNqO8yxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265096; c=relaxed/simple;
	bh=QeslFJAgR1S/xtujfToNTFjvP4iLf9oRTOHEggTlXlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWH3QNbYQygv/ushEa2VBJJ5YnCQCPGsY1kNnhYnHWdQ44FLmp12qw87Nd/4ORAb/w97fJ58W+l75DV3OcLrdWfY2/ZzD9uBLxYNP7fTB7Tlirh8Qb5y4vCyQ4xTXfg4KVQmaLy9PfX65wO5pjCGvtNSm4vnejXjhclmKUQkZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=heiaJ4jQ; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="heiaJ4jQ"
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id ol9uw2gCThJKMon0AwDAsL; Tue, 28 Jul 2026 18:58:07 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id on09wbexbWDCxon09wJCzy; Tue, 28 Jul 2026 18:58:05 +0000
X-Authority-Analysis: v=2.4 cv=Qpte3Uyd c=1 sm=1 tr=0 ts=6a68fbbe
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7T7KSl7uo7wA:10 a=PeOOapuUAAAA:8
 a=7CQSdrXTAAAA:8 a=PBOIwTC0ZoIbhxO_yKcA:9 a=QEXdDO2ut3YA:10
 a=0BaqRfgCL6CLbWgV2pdm:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y2OtRT2ttEnzcYF87Dz97K1NHdpKvda7LWBZSu8P8Sk=; b=heiaJ4jQcUnF+aW3iNlzmYWd0V
	0VysmtRLlMh36k9dtKzgaCuJ5W28liVdvHdsqJI6aoVAvtVFJw5DbNK22zrJk2dfTwEGRCLnT/Wqo
	k3qnEx0SQMa9EDDsbBciBDUXCovNBO7FM/GobjZP4LABadLnfDaHPR4WonGlPhrG9HI6XWT/gKR39
	5QD7DnzthgZO5d6+AsGsPFFMgZLxL0KCXwbrc+YlnggVlx74Ek1dYhq8/3qotRQmymiZSB3XRuLTE
	hIIompt1qgXET1Zi1f8EG+eDHaedNFKpMWwYkMlj3/9L3eIjn9sV3g5thblzI77a+sQBvfq8NSmZw
	ckeB+QPQ==;
Received: from [177.238.18.24] (port=54382 helo=[192.168.0.12])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1won08-00000002H9m-1mtE;
	Tue, 28 Jul 2026 13:58:04 -0500
Message-ID: <3aa0853e-278f-4825-b51e-42eb437111bf@embeddedor.com>
Date: Tue, 28 Jul 2026 12:57:54 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overflow: Support sub-union members in struct_size()
To: Bence Csokas <bence.csokas@arm.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260728114912.122417-3-bence.csokas@arm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260728114912.122417-3-bence.csokas@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.24
X-Source-L: No
X-Exim-ID: 1won08-00000002H9m-1mtE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.12]) [177.238.18.24]:54382
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfONqdrVTp4j1MHZk2OWuQDC51EhBtxrIpcrLHIsfLsGPceM9D3H9XggFrnUKvQINt1ebjaVxLgMndCAtIVP3MarzeoucLyn2TRnw4jx9eWUlKtwO0vQX
 7dp1ry3dLveVHoQ1fHS4JplQG8xcOq8Bw6lHIepWkycjEVBza54l7QW3k2VvKtsgr2mk0NOrSt/3L4nzGUXAOPXfrLUjHAWm5E6JhRDtDJUJdfVjvDVe/qzp



On 7/28/26 05:49, Bence Csokas wrote:
> Original definition of struct_size() assumed that the total size of an
> object with a flex-array member can be calculated simply by adding the
> flex-array size to what sizeof() returns. This is however not the case
> if the struct has a union inside it, and `member` refers to a field
> inside that sub-union:
> 
>    struct my_inner {
>      int a;
>      char b[];
>    };
> 
>    struct my_outer {
>      char c;
>      union {
>        struct my_inner inner;
>        long l;
>      };
>    };
> 
>    /* This will give the wrong result */
>    struct_size_t(struct my_outer, inner.b, n_elems);
> 
> Replacing sizeof() by the offsetof() of the member fixes this.
> 
> Existing users specifying non-union members should not be affected.

This actually affects users of flexible structs that have tail padding[1].

-Gustavo

[1] https://godbolt.org/z/KPq59EYej

> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> ---
>   include/linux/overflow.h | 4 ++--
>   include/linux/stddef.h   | 8 ++++++++
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index a8cb6319b4fb..a11c1135f617 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -433,8 +433,8 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>    */
>   #define struct_size(p, member, count)					\
>   	__builtin_choose_expr(__is_constexpr(count),			\
> -		sizeof(*(p)) + flex_array_size(p, member, count),	\
> -		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
> +		offsetofp((p), member) + flex_array_size(p, member, count),	\
> +		size_add(offsetofp((p), member), flex_array_size(p, member, count)))
>   
>   /**
>    * struct_size_t() - Calculate size of structure with trailing flexible array
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index e1851c50c89b..b8f0dbd2de55 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -32,6 +32,14 @@ enum {
>   #define offsetofend(TYPE, MEMBER) \
>   	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
>   
> +/**
> + * offsetofp() - Get the offset of a struct field from a pointer to the struct
> + *
> + * @P: Pointer to the structure
> + * @MEMBER: The member within the structure to get the end offset of
> + */
> +#define offsetofp(P, MEMBER) offsetof(typeof(*(P)), MEMBER)
> +
>   /**
>    * struct_group() - Wrap a set of declarations in a mirrored struct
>    *
> 
> base-commit: 62cc90241548d5570ee68e01aaba6506964e9811

