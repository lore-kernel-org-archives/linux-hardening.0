Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B71B87D5
	for <linux-hardening@vger.kernel.org>; Wed,  7 May 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639823; cv=none; b=OW9IQgpBR2qKfScCX+qC+MmLbM+P+tSjUwhzZ662WmS1+RW/G6HLvWh/XxKa2oqChTsC9b0lTQnYI2falz+SeIAV3Ex6SVoOlr5EYghd5YY5L/j/uczsJQnYcjyBkwOm3fpyOEFNHJQlb8gNEfK9oqhirb8nlFhvt6Hv4Rz0M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639823; c=relaxed/simple;
	bh=NEXoSWocaJ9V4iiharkBP6irUj3ivOwmKiwrfh2jEhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzrvIBeQzY+XAQfQR/nxryEnJKrbgvUvMByiF7X9lSOLTZvl4sddKGq7bmRNJYDpO7QBPLVGF5KOblifJZ9Q/zQN8tSfV0hfcdo3qNbzsQbwzzQs9qvE3yxYxvSd9oTELh0npmhPlyX0x1KDkqTKIfO0+T4DRdGCum/v9ZHCtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=GGWLqI3e; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GGWLqI3e"
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id CZ92uvywLMETlCimSuJuR7; Wed, 07 May 2025 17:42:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id CimRuiZO7PUhjCimRuWyj8; Wed, 07 May 2025 17:42:04 +0000
X-Authority-Analysis: v=2.4 cv=KsRL23WN c=1 sm=1 tr=0 ts=681b9b6c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=RP4Zo94yJkyqAg_2mxEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DYAcQdK5TBsllX0fpcYCVbWIIhpKqJdblg9zX6udYbA=; b=GGWLqI3eZq/lb/8efol6zKVTnE
	y9yTBmKVc8wZ9ogbV5hG0K0G3Gf9c+o0eXhUz3Ohz1+39U+xVhzJk95/N/gDeAcMgmbpxBR9e6hBM
	guWlHp4hXYi6/b6xneiP+Y/S54nC+jp/K+pi2e/AsRibCY/1xEbNBp8OLKRo4uHdoXzejl7xNyK/3
	Fiy78UEgxBHMO0t2VO1sUoSYbqtFdYlyTg/WC7qFt5psNVdkgODhdfrUkcOwEV2pfF5z4d1un8lzT
	5v8wq5SeUQgZkEjboKImhusWCfpxFXezOovxxrdf/omPzc/UwiNIZN3+cUluoJjo9xEnOqNfH/mO6
	swIVUx3Q==;
Received: from [177.238.17.151] (port=10278 helo=[192.168.0.102])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uCimQ-00000001wqE-3HpA;
	Wed, 07 May 2025 12:42:02 -0500
Message-ID: <50a3fe91-2120-4cd3-a64f-39d50ba9138c@embeddedor.com>
Date: Wed, 7 May 2025 11:41:55 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fanotify: Avoid a couple of
 -Wflex-array-member-not-at-end warnings
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aBqdlxlBtb9s7ydc@kspp>
 <CAOQ4uxj-tsr5XWXfu3BHRygubA5kzZVsb_x6ELb_U_N77AA96A@mail.gmail.com>
 <42nltwupsu4567oc5hioa4djga5yoqqoq3h7j3dj6vjr6hv4kt@54wdcs2wwefj>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <42nltwupsu4567oc5hioa4djga5yoqqoq3h7j3dj6vjr6hv4kt@54wdcs2wwefj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uCimQ-00000001wqE-3HpA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.102]) [177.238.17.151]:10278
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHWr7HIzjhmv5wUhYG9OajKUFLZcAgZJ5f4yYSt3pR9zd75oIl3wUekogWkY/ta6j27pKG48WsLfYjrhnPyTBLAz38MSejWfM2U16/riAQFx3gHeVxH9
 6IlDkL/z8XNGgq4uNvMxHiD7Pnykjcd8GFzPy75tCPu9I2nhR2LztlQ+6nRApr72mp15qTZwUXhFVg1YWafKNcW70hCo/P8pKnHjgckWWWkqNz5V0AnoKqfw



On 07/05/25 05:08, Jan Kara wrote:
> On Wed 07-05-25 07:56:21, Amir Goldstein wrote:
>> On Wed, May 7, 2025 at 1:39 AM Gustavo A. R. Silva
>> <gustavoars@kernel.org> wrote:
>>>
>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>> getting ready to enable it, globally.
>>>
>>> Modify FANOTIFY_INLINE_FH() macro, which defines a struct containing a
>>> flexible-array member in the middle (struct fanotify_fh::buf), to use
>>> struct_size_t() to pre-allocate space for both struct fanotify_fh and
>>> its flexible-array member. Replace the struct with a union and relocate
>>> the flexible structure (struct fanotify_fh) to the end.
>>>
>>> See the memory layout of struct fanotify_fid_event before and after
>>> changes below.
>>>
>>> pahole -C fanotify_fid_event fs/notify/fanotify/fanotify.o
>>>
>>> BEFORE:
>>> struct fanotify_fid_event {
>>>          struct fanotify_event      fae;                  /*     0    48 */
>>>          __kernel_fsid_t            fsid;                 /*    48     8 */
>>>          struct {
>>>                  struct fanotify_fh object_fh;            /*    56     4 */
>>>                  unsigned char      _inline_fh_buf[12];   /*    60    12 */
>>>          };                                               /*    56    16 */
>>>
>>>          /* size: 72, cachelines: 2, members: 3 */
>>>          /* last cacheline: 8 bytes */
>>> };
>>>
>>> AFTER:
>>> struct fanotify_fid_event {
>>>          struct fanotify_event      fae;                  /*     0    48 */
>>>          __kernel_fsid_t            fsid;                 /*    48     8 */
>>>          union {
>>>                  unsigned char      _inline_fh_buf[16];   /*    56    16 */
>>>                  struct fanotify_fh object_fh __attribute__((__aligned__(1))); /*    56     4 */
>>
>> I'm not that familiar with pahole, but I find it surprising to see this member
>> aligned(1), when struct fanotify_fh is defined as __aligned(4).
> 
> Yeah.

Yep, gotcha.

> 
>>>          } __attribute__((__aligned__(1)));               /*    56    16 */
>>>
>>>          /* size: 72, cachelines: 2, members: 3 */
>>>          /* forced alignments: 1 */
>>>          /* last cacheline: 8 bytes */
>>> } __attribute__((__aligned__(8)));
>>>
>>> So, with these changes, fix the following warnings:
>>>
>>> fs/notify/fanotify/fanotify.h:317:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>> fs/notify/fanotify/fanotify.h:289:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>   fs/notify/fanotify/fanotify.h | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
>>> index b44e70e44be6..91c26b1c1d32 100644
>>> --- a/fs/notify/fanotify/fanotify.h
>>> +++ b/fs/notify/fanotify/fanotify.h
>>> @@ -275,12 +275,12 @@ static inline void fanotify_init_event(struct fanotify_event *event,
>>>          event->pid = NULL;
>>>   }
>>>
>>> -#define FANOTIFY_INLINE_FH(name, size)                                 \
>>> -struct {                                                               \
>>> -       struct fanotify_fh name;                                        \
>>> -       /* Space for object_fh.buf[] - access with fanotify_fh_buf() */ \
>>> -       unsigned char _inline_fh_buf[size];                             \
>>> -}
>>> +#define FANOTIFY_INLINE_FH(name, size)                                               \
>>> +union {                                                                                      \
>>> +       /* Space for object_fh and object_fh.buf[] - access with fanotify_fh_buf() */ \
>>> +       unsigned char _inline_fh_buf[struct_size_t(struct fanotify_fh, buf, size)];   \
>>
>> The name _inline_fh_buf is confusing in this setting
>> better use bytes[] as in DEFINE_FLEX() or maybe even consider
>> a generic helper DEFINE_FLEX_MEMBER() to use instead of
>> FANOTIFY_INLINE_FH(), because this is not fanotify specific,
>> except maybe for alignment (see below).
> 
> Yes, I guess a generic helper for this would be nice but if fanotify is the
> only place that plays these tricks, we can keep it specific for now. I
> agree naming the "space-buffer" field "bytes" would be less confusing.

I can send v2 with this change.

> 
>>
>>> +       struct fanotify_fh name;                                                      \
>>> +} __packed
>>
>> Why added __packed?
>>
>> The fact that struct fanotify_fh is 4 bytes aligned could end up with less
>> bytes reserved for the inline buffer if the union is not also 4 bytes aligned.
>>
>> So maybe something like this:
>>
>> #define FANOTIFY_INLINE_FH(name, size) \
>>      DEFINE_FLEX_MEMBER(struct fanotify_fh, name, size) __aligned(4)
> 
> I guess you need to provide the "member" information to
> DEFINE_FLEX_MEMBER() somewhere as well.

Yeah, I can write something like that as well.

I'll come back with v2, shortly.

Thanks for the feedback, folks! :)
--
Gustavo

