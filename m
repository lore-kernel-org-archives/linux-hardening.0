Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E51DE4F6
	for <linux-hardening@vger.kernel.org>; Wed, 25 Jun 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872711; cv=none; b=ZnWc2DL20i4IiGjinxWb1GS/8xWM+rEHHiOjNiOPnQIBCC8aIRiaHKmhVY6N/5vrC5KG5GiVMWvlDHhWTdQJgtkHQrywnFn9rgqf9DjjG5Ir8uNVmHpK0cZCIpf016Zk3Wq9v50ZARFGJDMRGr6c0P2rXHpJvDvQLDrrXqbpRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872711; c=relaxed/simple;
	bh=+oiM/jJKH9YwxBfMrhanQg/Z/mRGBVXx53Iyt5TqR9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7ihiCSP/K/LbMKr8Uwbm59Veppo0+G4VzwP6DowAHCQ2OvYzG62jqJa1pKonyWElCQ52rIPb2zQeaMaHEKZ0h1DGcFrB9KKhfmUnEBT/Jr6aELHtb5zhY+EB6K1mUDk/IuhjWVUz7R2B+jO99loc1pT68TojwYWvOgmntNfW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wIv62U2M; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wIv62U2M"
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id URIOu73rwbmnlUTyJu9dew; Wed, 25 Jun 2025 17:31:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id UTyIu2SigJ4PgUTyJuhd7Z; Wed, 25 Jun 2025 17:31:43 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=685c327f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=BEqaKkcdS6MMFEc9jAMA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+I84/MI9zoV9OsiCK1atS49l1Bex64d49JeV33lBug8=; b=wIv62U2Mmt0hJA2iAd6m8+N3JU
	8PF7U9oJP3eyxnyFuhsHSdvk9Dm8iN83SezB/0pdsb4vTLL4Uf8JEGUj57qYQmHl450QGklqhMKX+
	bcNCUyQ+ZvZPzwsZTQuz5+cS7qFosnJ1RiXOcwCelfTbViREMEA3cB2N57yEWoKKg3jUktV8KmZn+
	p69NFE/kOFzjEKon4wlxPJN3tSAcl+P3soTW6+b9UCH9uuABSjLhg1fdRURMkHd6Euk/z0gZZzgWl
	261ebL5h6nV2vvvCd4RVMyDHELG1X/Vfd4fUBsa2VuFKui6WcwOqDzmBmRRYpDZOFYHXii3fgckjT
	goD3KpHw==;
Received: from [177.238.16.137] (port=54862 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uUTyG-00000004FMY-3YIQ;
	Wed, 25 Jun 2025 12:31:40 -0500
Message-ID: <e0adad17-5d4f-4309-9975-81971597da65@embeddedor.com>
Date: Wed, 25 Jun 2025 11:31:33 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aEneid7gdAZr1_kR@kspp> <202506250950.31C8A58E@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202506250950.31C8A58E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uUTyG-00000004FMY-3YIQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.16.137]:54862
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNFv4tlQNh0meEQDrEKc+CL0hx+VpC/SPsHdpBa97fXl1bcMAWBcyuphp/JVWApOS/2oBMOdMwiq8sS3+9clVLkYD5hbmDKJJq8PwfU+bTzAmPRkntGT
 iIzBk2Ddtrgs9GtIhv2XHt90rflhXVYaPDBSySVe3R2dY3idGN9phOLJBdvXT+O6C302sQNZ7kXH/QKw2eMuyNg6U2Wr+885hzsFWGVZHzOZpksws3NySlBQ



On 25/06/25 10:56, Kees Cook wrote:
> On Wed, Jun 11, 2025 at 01:52:41PM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Refactor multiple structs that contain flexible-array members in the
>> middle by replacing them with unions.
>>
>> These changes preserve the memory layout while effectively adjusting
>> it so that the flexible-array member is always treated as the last
>> member.
>>
>> With these changes, fix a dozen instances of the following type of
>> warning:
>>
>> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v3:
>>   - Use union instead of DEFINE_RAW_FLEX().
> 
> I think your TRAILING_OVERLAP macro[1] is perfect here. I'll try to get that
> landed for the next rc. Can you double-check that this works correctly
> in these cases?

Absolutely. If people prefer that route I'm happy to wait for the helper to
land in linus' tree.

> 
>> @@ -55,9 +55,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>>   {
>>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>>   	unsigned long security_flags = 0;
>> -	struct {
>> +	/*
>> +	 * This effectively creates a union between the flexible-array member
>> +	 * and any members after _offset_to_fam.
>> +	 */
>> +	union {
>>   		struct nd_cmd_pkg pkg;
>> -		struct nd_intel_get_security_state cmd;
>> +		struct {
>> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
>> +			struct nd_intel_get_security_state cmd;
>> +		};
>>   	} nd_cmd = {
>>   		.pkg = {
>>   			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> 
> I think it would be a pretty small and direct replacement:
> 
> 	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> 			 struct nd_intel_get_security_state cmd;
> 	) nd_cmd = {
> 		...

Yes, this works. Hopefully, maintainers will comment on this and let us
know what they prefer. :)

Thanks!
-Gustavo

> 
> -Kees
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/kspp&id=29bb79e9dbf1ba100125e39deb7147acd490903f
> 

