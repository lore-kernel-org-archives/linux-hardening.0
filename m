Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7DC127B46
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163266; cv=none; b=rlvTWGUqcmdyMLmq8Z0VV1Bnu7Fpy9CLN+2BoFc+kFuI/01ZbFHdp36o7P7KsCNgkMi43Dkk+MZNkKysg3qV5gw/XN6nckZRzSottZ4TEWigCnAuQk0EtQ0ex9p6yZGI9yEoZWIkOISMlY9Gftb5320W6i4h80r89VkF7CMlTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163266; c=relaxed/simple;
	bh=hJbMgD7E4Jeq3JYeyBlsdRwDJ32MwyzK6QU1xS9lnNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+tEpE1vYmSl1wkFw5HDIlMW3a+kUbq3+VOF/OZFpMTpoVcZhPEX/CEW1wLG4O22c3pwvo11yjDqajT99GF69FZnkHrXCDVgUnOcWqqvFY5nZjuKD1wePC/2MBPeWMmoNDTUOCNFtbXQ3fiv8dhTeJ3IxhHq0EaD77nzXNdcquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mZq2Z8DJ; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mZq2Z8DJ"
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id X3Bzr0iy39gG6X59ErN2sf; Mon, 05 Feb 2024 20:00:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id X59DrAlLZYElpX59DrHwen; Mon, 05 Feb 2024 20:00:55 +0000
X-Authority-Analysis: v=2.4 cv=WfivaFhX c=1 sm=1 tr=0 ts=65c13e78
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=lXWNAtzADcZZgIjtGc4A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7U7jwv7kw0IAiZjuYfDWc8VSfxYMNew1tgp5qVklIE0=; b=mZq2Z8DJn9x2Z89W+MQZrRkOtJ
	/zoZ+eaBp6NDKHJoKVwcHhdBPaC0LHnhvwL83R12KqBkLigNK9tzHJyn1jWju6CRFBSHOvhkFhFr6
	OWtBEB74MPKdrzrBVjZjH1+xhASvTz0GCSL3tUwBQzA+99jVP/z0JrOYcIo4ijfFZP4cE5N5O+mHC
	z4sKK0Yit4Qed5mhBU5PWwgxB6Ft3QyLzhZkN6HH+btqRUtAevBYgcgH6lk4bLoieZ7mJbhjLScai
	JQF2JFldI4l16MvRZKJlT8jdr7/32IzpqPKxKY+J6oWLFXFXVOhpApfQtA6N9ZuNo4jV2Jv2f4qZM
	kf0Dt2fQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34988 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rX59C-001Oci-2u;
	Mon, 05 Feb 2024 14:00:54 -0600
Message-ID: <992f0e89-3d24-4bc1-8850-e1314f031413@embeddedor.com>
Date: Mon, 5 Feb 2024 14:00:53 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] overflow: Adjust check_*_overflow() kern-doc to
 reflect results
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Mark Rutland <mark.rutland@arm.com>, Marco Elver <elver@google.com>,
 linux-kernel@vger.kernel.org
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-1-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240205091233.1357377-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rX59C-001Oci-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:34988
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPtG+2okiC9m4P3YvQf0Yboh67sUDeeM1yZmf6qhowaC13apMOkr14un7mBin5nS8rxeri/B6TfMAxb86efIdJ5j3dvkDge1+628+tb/Md3PyA2tA0Cv
 MvqgXL7MbvmqWxSwSh2M+S/bIyX9iEfRpgzkmQTNBRem1l85GKF3jpsJdaPHYCDirbyYgW/wPcBkCi2hJUz11IKHU3Fxb3mebJWHSti13PyNEc069N0PLhbM



On 2/5/24 03:12, Kees Cook wrote:
> The check_*_overflow() helpers will return results with potentially
> wrapped-around values. These values have always been checked by the
> selftests, so avoid the confusing language in the kern-doc. The idea of
> "safe for use" was relative to the expectation of whether or not the
> caller wants a wrapped value -- the calculation itself will always follow
> arithmetic wrapping rules.
> 
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Better to be concise and direct. :)

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   include/linux/overflow.h | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 7b5cf4a5cd19..4e741ebb8005 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * @b: second addend
>    * @d: pointer to store sum
>    *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>    *
> - * *@d holds the results of the attempted addition, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * sum has overflowed or been truncated.
> + * *@d holds the results of the attempted addition, which may wrap-around.
>    */
>   #define check_add_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_add_overflow(a, b, d))
> @@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * @b: subtrahend; value to subtract from @a
>    * @d: pointer to store difference
>    *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>    *
> - * *@d holds the results of the attempted subtraction, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * difference has underflowed or been truncated.
> + * *@d holds the results of the attempted subtraction, which may wrap-around.
>    */
>   #define check_sub_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_sub_overflow(a, b, d))
> @@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * @b: second factor
>    * @d: pointer to store product
>    *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>    *
> - * *@d holds the results of the attempted multiplication, but is not
> - * considered "safe for use" on a non-zero return value, which indicates
> - * that the product has overflowed or been truncated.
> + * *@d holds the results of the attempted multiplication, which may wrap-around.
>    */
>   #define check_mul_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_mul_overflow(a, b, d))
