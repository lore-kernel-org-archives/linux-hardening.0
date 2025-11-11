Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F82FF673
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863259; cv=none; b=AGoUnO7dDZe0Lhuchj9lX/NBbhhCjs7/S2G4UCifsQoqD3udEWzWkIe1xuCLwu0ONayJ0vQfubd5TFpUeV/+RYolBjojfj6PQJugVfMBRNi7g6M8aQGkwCbFbmpBC4T8D1pjS65INiQF8NxH2lHY09yYT6zDNkEiycHfsanwzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863259; c=relaxed/simple;
	bh=7PE1Ra6Wd21DmBff64tqh3yjwSx+bptn3SGutDd7UGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiEfu29HHHAhVSUdIytymY9IUR83IbNpmlkUn6DfqB10UYy+kCoikP4aCKGTf1zSbX9HLERXBsvp9yUsFsC6LICeq+MGh9YaUIRM/DfCOHXJhEN32n0uBGrpDhyplhZk3rZpUGPuzUs9uT59EcfpmRgcCPRjarzM6xT8ctCNh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=IIYDpcXV; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IIYDpcXV"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id InGJvTTuJU1JTInGJvfG63; Tue, 11 Nov 2025 12:14:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id InGJvsQfuuWNOInGJv55YS; Tue, 11 Nov 2025 12:14:15 +0000
X-Authority-Analysis: v=2.4 cv=N+gpF39B c=1 sm=1 tr=0 ts=69132897
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=F0GicbU7tRTSLTLZ85HXVw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=oBrga82o3JoBcljm_xYA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YHkNqbWnHwvdQg3BLnlc11EHlTVWBrg1MAlKIBmYEBw=; b=IIYDpcXV7hQM8CE6fsCi1jQkDs
	zQgAvdaPn+V/l/ERdNXhMCVR7pD4QQR2a0L4afe6/QfHXjjlVAFd6rDK+6DVFykG7cfYVAoeKLMft
	b0afW8alX4NRdXcsH9FnAxnbncQood2+s3rCiX7q2F5tp6RIrMPeSQcuw3p5tKOhqK6NRgnKqTGxm
	BlC/+hiiKobes9wJx0d6mWvBeOOXACVV0dDLG3YyounnrH8wHPwz5XRLbkxJC7900Gc6buqym2ogT
	MNR1G+nqmNV2sr86N2fWDfRg2wMDCVOwsjSYXxegSe6p4daNeGGip7cdCkDSxNDTTctzrpyMK0Gq8
	cSsmprsQ==;
Received: from m106072098064.v4.enabler.ne.jp ([106.72.98.64]:45116 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vInGI-00000002Z9Q-2mWK;
	Tue, 11 Nov 2025 06:14:14 -0600
Message-ID: <a9e5156b-2279-4ddd-992c-ca8ca7ab218a@embeddedor.com>
Date: Tue, 11 Nov 2025 21:14:05 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Leon Romanovsky <leon@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251111115621.GO15456@unreal>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251111115621.GO15456@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 106.72.98.64
X-Source-L: No
X-Exim-ID: 1vInGI-00000002Z9Q-2mWK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m106072098064.v4.enabler.ne.jp ([10.221.86.44]) [106.72.98.64]:45116
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKGhfxBB7elHhxN+4afeBW6AA7O9Kr4FbZDN3zvrew6RRyaUHwMt0yhT2vyyWs0RFZERtx2xsW8EkDH4h9gtA3nPOxP+HIrm45g9KrI71DFS9I4/RWxP
 rGFKAXOJkeJJwZLIE1lkc0p4QvXMARLsRBf7gIJRM6JoIFZe+2WSc4WbCjO7R3QN74tLiWFSRhlBY+7eR4K44tlPUpDhAqhVBMyJYOavUm2IT/uzZLtqRF9O



On 11/11/25 20:56, Leon Romanovsky wrote:
> On Tue, Nov 11, 2025 at 12:35:02PM +0900, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>
>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM) and a
>> set of MEMBERS that would otherwise follow it.
>>
>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>> start of MEMBER aligned.
>>
>> The static_assert() ensures this alignment remains, and it's
>> intentionally placed inmediately after the related structure --no
>> blank line in between.
>>
>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>> to the end of the corresponding structure.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index fd48075810dd..6498d61e8956 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>>   	u32			rkey;
>>   	u32			length;
>>   
>> -	/* SRQ only */
>> -	struct {
>> -		struct rxe_recv_wqe	wqe;
>> -		struct ib_sge		sge[RXE_MAX_SGE];
>> -	} srq_wqe;
>> -
>>   	/* Responder resources. It's a circular list where the oldest
>>   	 * resource is dropped first.
>>   	 */
>> @@ -232,7 +226,15 @@ struct rxe_resp_info {
>>   	unsigned int		res_head;
>>   	unsigned int		res_tail;
>>   	struct resp_res		*res;
>> +
>> +	/* SRQ only */
>> +	/* Must be last as it ends in a flexible-array member. */
>> +	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
>> +		struct ib_sge		sge[RXE_MAX_SGE];
>> +	) srq_wqe;
> 
> Will this change be enough?
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..9ab11421a585 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -219,12 +219,6 @@ struct rxe_resp_info {
>          u32                     rkey;
>          u32                     length;
>   
> -       /* SRQ only */
> -       struct {
> -               struct rxe_recv_wqe     wqe;
> -               struct ib_sge           sge[RXE_MAX_SGE];
> -       } srq_wqe;
> -
>          /* Responder resources. It's a circular list where the oldest
>           * resource is dropped first.
>           */
> @@ -232,6 +226,12 @@ struct rxe_resp_info {
>          unsigned int            res_head;
>          unsigned int            res_tail;
>          struct resp_res         *res;
> +
> +       /* SRQ only */
> +       struct {
> +               struct ib_sge           sge[RXE_MAX_SGE];
> +               struct rxe_recv_wqe     wqe;
> +       } srq_wqe;
>   };

The question is if this is really what you want?

sge[RXE_MAX_SGE] is of the following type:

struct ib_sge {
         u64     addr;
         u32     length;
         u32     lkey;
};

and struct rxe_recv_wqe::dma.sge[] is of type:

struct rxe_sge {
         __aligned_u64 addr;
         __u32   length;
         __u32   lkey;
};

Both types are basically the same, and the original code looks
pretty much like what people do when they want to pre-allocate
a number of elements (of the same element type as the flex array)
for a flexible-array member.

Based on the above, the change you suggest seems a bit suspicious,
and I'm not sure that's actually what you want?

Thanks
-Gustavo





