Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D391345EAC
	for <linux-hardening@vger.kernel.org>; Mon, 24 Aug 2026 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787544820; cv=none; b=urTWi6KbzmN6qe/i3rJRGKiMrSiEfbxFRJ3NYB6nTpnoi/rMUuv8qvov6dER+UpDd7qpJOSMe8gYgfrb0vFGJz1tPxcUtOyuvged6wynUNNMVcGtmw/3TlMpE5RBQXFjg/iUNojU77WcL/EZpUMSB7Turumbu8adnjrs+RA5KDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787544820; c=relaxed/simple;
	bh=2435xp/9ahmNbyLQQVb83N0Lr+B9SCy1d+uEr0MAl6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0R8SiSAN26vdxYqJ+1QDRgzmihmgnZYAItrOAJzQsRaoynbzmxMA7sAhYkeQWStLJFJdkJqoMvQ1AC+N22EnMPHkO+8uvaKLMR9ohUsPAXjfFk2tpo2bChrPhvl+kt0ijUBbrwvIizB9C+ViYsICl4EF+sysCmZN22PgXSbqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jAGl1pjN; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jAGl1pjN"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id yHxmwSyrhusRSyM3xwWt7P; Mon, 24 Aug 2026 04:13:33 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id yM3vww1BffDqYyM3xw7p5M; Mon, 24 Aug 2026 04:13:33 +0000
X-Authority-Analysis: v=2.4 cv=HKbDFptv c=1 sm=1 tr=0 ts=6a8bc4ed
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=nzuXsxulAAAA:8 a=pGLkceISAAAA:8
 a=7ipKWUHlAAAA:8 a=vaJtXVxTAAAA:8 a=iox4zFpeAAAA:8 a=69EAbJreAAAA:8
 a=4RBUngkUAAAA:8 a=7fLVpWw6CxgmVm_BPEcA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=Jn5cl5okm61iLnyvC_SE:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gj4LfR3NBw51e8QVdaIwPPt1n59fzXjAnZBVB9Yaggk=; b=jAGl1pjNgmwez7x3hhwtZlfx3k
	7RlOP/wGqfxdI4A6xXRGz2bfBwSMwsMus8Jf7EngqITqpXWtg9sT23M1myxsjhHUAWO6Nro4Ha19r
	jaNC2CWxuv6gDqqPHCDODD2Mf9NVzIJfpwyc3EvgMWXydK/RLkwByT7HC8/sIL27nPr6DnxxACfwe
	+IY+XABFm3r4oI1oqUoBVRRt9kD3Q+ENKxsoINBySUP5y8F9/bRHMAaS6GXZiBeCvPpL6Z1WyKr6v
	TyUGB4vP7YJhRsDg8/DkuBsaBxvOZ2NYWkgmtIPrbsXVmfh9ibE0brf9ftvhAvGUkst+lZi/cKQpg
	tzRDE9Vg==;
Received: from [59.16.68.142] (port=55006 helo=[192.168.0.146])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wyM3s-00000000NgN-0uXx;
	Sun, 23 Aug 2026 23:13:28 -0500
Message-ID: <ecc6ab92-232b-4637-a626-12dfffd7b1a2@embeddedor.com>
Date: Mon, 24 Aug 2026 13:12:35 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stacktrace: Add __counted_by_ptr attribute to struct
 stack_trace
To: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, Petr Mladek <pmladek@suse.com>,
 Kir Chou <note351@hotmail.com>, codemender-patching+linux@google.com,
 linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com
References: <20260823123549.1120133-1-morbo@google.com>
 <20260823123549.1120133-2-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260823123549.1120133-2-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 59.16.68.142
X-Source-L: No
X-Exim-ID: 1wyM3s-00000000NgN-0uXx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.146]) [59.16.68.142]:55006
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP7lJCDIfewT06YI893IiSo04bzy5EJEZo0PfbSsdFHQuISADLvAEVms4RgU7O8OJbQQ6iRPOISLBcv1iWVQ7cMNaWEglqTRWllIBfINzUdOr87+uDpb
 P+GlLRmZNrsxPvnbdXEJDNryNe/z6rruOQ8Xn6w8dOkcgmdkVgWKDcRp8sLMI+o59cDaUmUZTXmw2amHL+KhsgRMLcnz2119e8cIqYCmLP+KLh8/TK6bmPbT



On 8/23/26 06:35, Bill Wendling wrote:
> For hardening and catching out-of-bounds accesses to the 'entries'
> pointer field in 'struct stack_trace', associate it with its count
> field 'max_entries' using the __counted_by_ptr attribute.
> 
> An analysis of the codebase reveals that 'struct stack_trace' is
> instantiated and initialized across several entry points in
> 'kernel/stacktrace.c'. In each execution path, 'trace.entries' is
> assigned a buffer of size 'size', and 'trace.max_entries' is assigned
> 'size' concurrently within the structure's initializer block. The
> pointer is not accessed before the count is set.
> 
> Because 'trace.entries' is always assigned at the same time as
> 'trace.max_entries' during initialization and is never reallocated
> or accessed beforehand, there are no uninitialized access windows.
> The 'max_entries' field accurately holds the exact element count
> of the buffer allocated for the 'entries' pointer, ensuring that
> compiler fortification and KASAN bounds checks using __counted_by_ptr
> do not trigger false-positive bounds checks or runtime panics.
> 
> Assisted-by: Gemini Next
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <david@davidgow.net>
> Cc: Rae Moar <raemoar63@gmail.com>
> Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Kir Chou <note351@hotmail.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>   include/linux/stacktrace.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> index 97455880ac41..fbb0925d8864 100644
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -81,7 +81,7 @@ unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
>   /* Internal interfaces. Do not use in generic code */
>   struct stack_trace {
>   	unsigned int nr_entries, max_entries;
> -	unsigned long *entries;
> +	unsigned long *entries __counted_by_ptr(max_entries);
>   	unsigned int skip;	/* input argument: How many entries to skip */
>   };
>   

