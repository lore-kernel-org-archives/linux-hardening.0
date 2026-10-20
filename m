Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498331;
	b=knxIGV7HzZul8Iu9gyu7QljGdDttVXfX3AsQK3ippsn9POPMfMEPNo+qHmFEY/MCgEOI
	 A4Tmxkj1vyEdH0DA2HjnfYS4Cf/7gmp7ytChRJkEInnRKnyaJoSYgro519VW6M9E++YiY
	 pXwH8rJrMMZ7IdoXJyrMsV5ApYuEGqzhhsqR8Zop+j2s68jydaqaDZ5XIx52A9Atrycpd
	 bAAbC4QXHDtTt43d06gJIXdH+lH7l6ouB/YHSWauCenvt6ADB/LnjRfp9NvKWCt9bE59e
	 LWOluMRfSy6Xwr8phQNKEXwHhpw+Ij89l8xWUPZABOegCaWheNr/dEcE8UzrIV3eLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498331;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=tW+jOFa0bAPRo5ob6iKpdpiylE+QgPpSwSf2SsyL4p0=;
	b=ZbSRZak4BWU+dGWrOzmVkpbySJ2VLePChwOg40P6YH1FkUy8tXXJaU8Z0QYakvTmOAoo
	 AnonQjqcX2JMlw2+yucj0yl3ukyR/a3iH5m3MzNV8Gl76CnVlLaltoRrXROOKmoYVKA93
	 hH6V/VgxCydSirxfQ9FPQSGArblMbsF9sKfowVHK6wZ6F2Znzaarypq1+x0A5zmD8OKW+
	 7KkKoPkRjof0MAD6BMkhA6RKcfjR6QTHWrB/+mcDILOUXilhmSULeslMFWg6ukwneE+og
	 MSkMnL/sYIXMmfevA8ys0sj9oyCUnopopd8lug4skhkcev7llyr7HvCypgkd+UXogqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=embeddedor.com;
	spf=pass smtp.mailfrom=embeddedor.com;
	dkim=pass header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=AbVyf0EC;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3D606A319
	for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 12:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A3D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=AbVyf0EC
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id J6YexRRf5v0ndJ8hHxLZzF; Tue, 20 Oct 2026 12:12:03 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id J8hGxo1jxouFZJ8hHxs5Yj; Tue, 20 Oct 2026 12:12:03 +0000
X-Authority-Analysis: v=2.4 cv=Zd4dNtVA c=1 sm=1 tr=0 ts=6ad75a93
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=7T7KSl7uo7wA:10 a=9AdMxfjQAAAA:20
 a=FmNn6hfUth-HS78a2iwA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
 a=bA3UWDv6hWIuX7UZL3qL:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=tW+jOFa0bAPRo5ob6iKpdpiylE+QgPpSwSf2SsyL4p0=; b=AbVyf0ECm4W7
	tIKrNrtOl/QoYsbOfllsmecnIpcjx7XMr0JAxyB0D+8FDXSGxp9sUKHssuTqvu7XcoD4dB/n4VehD
	/UUqQg+lcKsgGHanroZ2XiCNePZ8hhEwdk8luTpo1DS6wxPLrg4LXCRsnSb5WCP5/TFD8vQjXwC11
	XWXs99OZmjcQwjkbqNOoDrylTUpO3h51NGLxYvVEiorCHen2gqpxsclFYkEz1d/dLC80Cj849335X
	90/z1TZIUUo5BneulKzuw3La3huIen69cHvLQ+5Xwra8BE0RvlEV1scU8zv3JcG5bxGiNKNzbHYIn
	3Ly49No4/31RKSSWVNooQA==;
Received: from [1.234.115.197] (port=33036)
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1xJ8hE-00000000wsV-45S0;
	Tue, 20 Oct 2026 07:12:01 -0500
Message-ID: <6cf42177-5c35-49b8-9e4b-36a4d28aa26e@embeddedor.com>
Date: Tue, 20 Oct 2026 21:11:47 +0900
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kexec: Annotate umem_info members with
 __counted_by_ptr
To: Thorsten Blum <blum@kernel.org>, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aditya Gupta <adityag@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260730130248.597249-2-thorsten.blum@linux.dev>
 <7d99725f-9c90-48ca-bee1-30e2e6c06617@linux.ibm.com>
 <asDClaRrHuKB44X-@kernel.org>
 <dbb4580d-7e20-4c38-9716-f39cf81a4942@linux.ibm.com>
 <asNfSSp-AckyeO7P@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <asNfSSp-AckyeO7P@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 1.234.115.197
X-Source-L: No
X-Exim-ID: 1xJ8hE-00000000wsV-45S0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([1.234.115.197]) [1.234.115.197]:33036
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCs95MrWmHxs4bA1mSGVQEKhNtuunIG4WWVbW/q1AnJr+Jqsf6WoamomjemBBNhG/4EfDRbYflVz2RVCgjVlNYMloKeJK8ZFHo9vdY4Jt01Brw+xH9B0
 sGElcJuf9YewtVWcBDRKyYyYDtiG98p+f1GDCCkvC1OtckLXgcp++gpMOFuhuYPmx4zHP3mp+fkLzUGSkM3ec3PBgSFYDfGuJZV8h5ZK3YvJtfROQ49l+IRr



On 10/5/26 17:26, Thorsten Blum wrote:
> On Mon, Oct 05, 2026 at 01:42:01PM +0530, Sourabh Jain wrote:
>> On 03/10/26 14:23, Thorsten Blum wrote:
>>> On Fri, Sep 25, 2026 at 11:49:04AM +0530, Sourabh Jain wrote:
>>>> On 30/07/26 18:32, Thorsten Blum wrote:
>>>>> Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
>>>>> improve access bounds checking via CONFIG_UBSAN_BOUNDS and
>>>>> CONFIG_FORTIFY_SOURCE.
>>>>>
>>>>> Set the count fields before assigning the corresponding pointers, return
>>>>> early on krealloc() failure, and use sizeof(*buf) when deriving
>>>>> max_entries from the allocation size.
>>>>>
>>>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>>>> ---
>>>>>     arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
>>>>>     1 file changed, 12 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>>>>> index 8c72e12ea44e..6424b668f0e9 100644
>>>>> --- a/arch/powerpc/kexec/file_load_64.c
>>>>> +++ b/arch/powerpc/kexec/file_load_64.c
>>>>> @@ -34,14 +34,15 @@
>>>>>     #include <asm/cputhreads.h>
>>>>>     struct umem_info {
>>>>> -	__be64 *buf;		/* data buffer for usable-memory property */
>>>>> +	/* data buffer for usable-memory property */
>>>>> +	__be64 *buf __counted_by_ptr(max_entries);
>>>>>     	u32 size;		/* size allocated for the data buffer */
>>>>>     	u32 max_entries;	/* maximum no. of entries */
>>>>>     	u32 idx;		/* index of current entry */
>>>>>     	/* usable memory ranges to look up */
>>>>>     	unsigned int nr_ranges;
>>>>> -	const struct range *ranges;
>>>>> +	const struct range *ranges __counted_by_ptr(nr_ranges);
>>>>>     };
>>>> [...]
>>>>>     const struct kexec_file_ops * const kexec_file_loaders[] = {
>>>>> @@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
>>>>>     	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
>>>>>     	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
>>>>> -	if (tbuf) {
>>>>> -		um_info->buf = tbuf;
>>>>> -		um_info->size = new_size;
>>>>> -		um_info->max_entries = (um_info->size / sizeof(u64));
>>>>> -	}
>>>>> +	if (!tbuf)
>>>>> +		return NULL;
>>>>> +
>>>>> +	um_info->size = new_size;
>>>>> +	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
>>>>> +	um_info->buf = tbuf;
>>>>
>>>> Could you please explain why size and max_entries are updated before the
>>>> buffer itself?
>>> __counted_by_ptr() requires the counter ->max_entries to be set before
>>> the ->buf pointer is assigned; otherwise you have an inconsistent state
>>> where the counter doesn't match the pointer.
>>
>> But isn't updating the counter holding the buffer size before the actual
>> buffer
>> can cause problems?
>>
>> Can you share the document link of __counted_by_ptr() which says that size
>> counter to be
>> updated before the buffer pointer.
>>
>> Here is an example in fs/coredump.c file where size counter is updated after
>> the buffer
>> with __counter_by_ptr():
>>
>> https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L98
>> https://github.com/torvalds/linux/blob/a90ee4305c4a5df72c11b31dacfdc76e00fcf78a/fs/coredump.c#L115
> 
> Maybe the order only matters for flexible arrays and __counted_by(), but
> not for __counted_by_ptr(). I reordered it mostly out of habit from
> __counted_by() annotations and assumed the same rules apply for
> __counted_by_ptr(). Happy to restore the old order if it's not required.
> 
> Kees or Gustavo, what's your take on this?

The order matters when dereferencing the pointer. In this case, it's just
an assignment.

Thanks
-Gustavo


