Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610741272C9
	for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036569; cv=none; b=h0mewnODMEoQOyVVUdDEuiyTSChWIDXL0SufXhmVb6m7JaqyNNY/wxtqpvw2lCyyQvzR5n85JM9UCvIFHzlp6uFVgRXCpGW9uVitoTYM8m8EErqrwfeu2CND6B5Q2hQpeHYNvX8qaLgoRdOb86ynYwPYTMe0uh5V/bgPoPWG9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036569; c=relaxed/simple;
	bh=oUSS9WbWUjleqESpW9c98IHhFOzKOgqmvwrILKrh0+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZloRguYPVOrv6ALQNeUXjQ9aSXPy+zvDlE6MAdGILRKdC5NYeKJB9Yw9MWIVmMF0u1Gse8amC2AEsZCVe/VczbdkbQhEMGecC/1T+vtUdJXPMNOCUwQSfEccKW+I9EJyaHLWKXh1LTTutj+EKf8mRuutwOloL0+Ug+TLbB3BlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=M9uj0aWz; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="M9uj0aWz"
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id myjcrebHLtf2QnKlyr2pzX; Thu, 21 Mar 2024 15:56:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id nKlsreaOH9zHMnKlsrHFQv; Thu, 21 Mar 2024 15:56:00 +0000
X-Authority-Analysis: v=2.4 cv=fo4XZ04f c=1 sm=1 tr=0 ts=65fc5890
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=pzMpKnHA-g9QxEOb-IoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A+WmTPuzkgZDSVrrCRyuXerhZHil+NNsnP3DC6nYWLs=; b=M9uj0aWzYqMtuCLokuF8MmFkPb
	EJ0Xg5HQdoz3H03McPCY1gKkd+rX2+3UUt6BetiYwYq6SAu2IFYyzWA1LYQWZqHUG3kqVYH8cKI9O
	c/QHrrUZDxdTFaoq21I6FdsAVX5N5n4gKzD3l3FAHCLG3lko4HdID3R/v+gw4xGsVydK6vSQbvwPT
	FAraZMHsUIJ+XuF2/GyqgS0NWSitOp/SOR0Oh/P7AF+5jhangUPumjvU46aJvHN1BvxquFDHG7ZS4
	rjwnDHCL4xgB+cYqwTpUn3OGbmCxib97UU9+IgPtUvDon8YxACiRAtdQJEAXC8gNSXT1LUNeZp3uM
	GgboiAPg==;
Received: from [201.172.174.229] (port=45852 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rnKfa-003VSS-2i;
	Thu, 21 Mar 2024 10:49:30 -0500
Message-ID: <afa0afb7-f756-45d0-97ab-44205e984199@embeddedor.com>
Date: Thu, 21 Mar 2024 09:49:29 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZfuzWku+ip4fsZrb@neat>
 <267f340e1b309cff2fab01f83a141ee465296907.camel@linux.ibm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <267f340e1b309cff2fab01f83a141ee465296907.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rnKfa-003VSS-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:45852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB77vivteZvDz5SAPBvA9AooHarDfOy5bi4qDpSK55oAyctbSeHLfWyo/i8sr4Wc2NOaY30Jc4zXsel2401taR6ReiZOObXqq79zyq6Xk1I4gOLwqlnz
 DHbbuH+rHyEdBB/4fNHl8nTvDRuQ05HYpiqjiD8DqZitvekU3Z4dDkqxtJb/DKLhAhZl2T6itDM6r8oovLrXZ5rVMexup5SSuzEMy/qSXziTsdK4fNLvKyxF



On 3/21/24 07:58, Mimi Zohar wrote:
> On Wed, 2024-03-20 at 22:11 -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> There is currently an object (`hdr)` in `struct ima_max_digest_data`
>> that contains a flexible structure (`struct ima_digest_data`):
>>
>>   struct ima_max_digest_data {
>> 	struct ima_digest_data hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of a struct, we use the `__struct_group()` helper to separate
>> the flexible array from the rest of the members in the flexible
>> structure:
>>
>> struct ima_digest_data {
>>          __struct_group(ima_digest_data_hdr, hdr, __packed,
>>
>> 	... the rest of the members
>>
>>          );
>>          u8 digest[];
>> } __packed;
>>
>> With the change described above, we can now declare an object of the
>> type of the tagged `struct ima_digest_data_hdr`, without embedding the
>> flexible array in the middle of another struct:
>>
>>   struct ima_max_digest_data {
>>          struct ima_digest_data_hdr hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
> 
> And similarly for 'struct evm_digest'.

Yes. :)

> 
> 
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure.
>>
>> So, with these changes, fix the following warnings:
>>
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
> 
> I assume these messages are gone.

Yes. :)

Thanks
--
Gustavo

