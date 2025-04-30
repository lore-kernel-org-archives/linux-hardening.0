Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5361411DE
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042123; cv=none; b=FeMFCxZ483B1xSesog/S0lLGzdGPK4jqnqj1uXptJpF/KD19jUog55T+U8ddYDJOm8XjEUVhLgQcSoJ55uuE+91o0hNy8xGQYXuQV7Idwm3Y2B+83Z/YEGhvg5TzE8sHchV13XT0dzXA2wFJoFkssIjW8m7VV+FBpv3BHMI6R3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042123; c=relaxed/simple;
	bh=aNlI5doREuFnpNBygwYJ3vVeRE4exj3jm3zEaNbahzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwP5t34BhcKFo0cgyoeznj1bOQvvPoANMiry8C7sXc9JZ499dhXqVmXKRFi2TisoYqrHxIseopiNVaveJjRvGjmj64ETHTz0wMKVZg5HW7luRa9UXlhO8L+XrnFc+umO8Sn5qpazECMhCq9Ph1MGhXlwksNb5KgeTk6B/+I3hxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Mj/tOxD9; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Mj/tOxD9"
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id 9zYDu62I9f1UXADJbuqNFI; Wed, 30 Apr 2025 19:41:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ADJauGsWURxIGADJaunMaw; Wed, 30 Apr 2025 19:41:54 +0000
X-Authority-Analysis: v=2.4 cv=N/viFH9B c=1 sm=1 tr=0 ts=68127d02
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pWlpG66K428ilhL_DWUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bjBrQjQU2afaw/LgDKWhKIXfjuWHuTWx5Msxh3WnN5Y=; b=Mj/tOxD9PutqF7L7pmpkZUOujQ
	zUq/sOjq3INBElVfO+dyqRIfdtf2RIGY61ahoAUVv8w1oNhos33PUewqsonq7E0ZPAGBqwKXYn2us
	0IOsf9uqAhD2HT1cySyw7qUzw8qgvMAhB942pmYdS0qvXG8utkUxxS3zgFttrThCStSu+eRBGgMrx
	ZYosA+tTCQYsfjprs7rs8CqstKr581CVKlzgp6XDUq16w7IRZSL81ezZ0U4TIYLR5efgCBLKNnLFR
	EgcsyglBIC7px8NLYB4Mn8z9wID9TL6B0Osuyg/8Rxo3LaWLiz5+/j64OagP8OYi+udUQZXNNvW3J
	dJLLsdoA==;
Received: from [177.238.17.151] (port=23848 helo=[192.168.0.101])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uADJY-00000002pqq-0b9b;
	Wed, 30 Apr 2025 14:41:52 -0500
Message-ID: <df338a70-fdfc-427e-9915-8b9e50de93ad@embeddedor.com>
Date: Wed, 30 Apr 2025 13:41:39 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] acpi: nfit: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Dan Williams <dan.j.williams@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z-QpUcxFCRByYcTA@kspp>
 <67e55ac4dfa2e_13cb29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <67e55ac4dfa2e_13cb29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uADJY-00000002pqq-0b9b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.101]) [177.238.17.151]:23848
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJs4kUQQd/fmpu32zZQADv57dzqR2X8u/zPKThK8MByzl70bgCDG7bEExA0C9pfwMGuPS12XNvYBwSx+tmpD0r6oKUp2jvY6/Plcp/xltqPt8zKy0q/e
 A6GlvTZ0RQZVSKsZj/FLwCogP6TiKXM5u6h2Gppie7+KHs3Qt3Tpir+GRGfj088/AYc1FStKs3lhlBBizzMRC5wEkLGNn+8I/sV2pPinDtPACbZV75T7fHpm



On 27/03/25 08:03, Dan Williams wrote:
> Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> So, with these changes, fix a dozen of the following warnings:
>>
>> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>   - Use DEFINE_RAW_FLEX() instead of __struct_group().
>>
>> v1:
>>   - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
>>
>>   drivers/acpi/nfit/intel.c | 388 ++++++++++++++++++--------------------
>>   1 file changed, 179 insertions(+), 209 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
>> index 3902759abcba..114d5b3bb39b 100644
>> --- a/drivers/acpi/nfit/intel.c
>> +++ b/drivers/acpi/nfit/intel.c
>> @@ -55,21 +55,17 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>>   {
>>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>>   	unsigned long security_flags = 0;
>> -	struct {
>> -		struct nd_cmd_pkg pkg;
>> -		struct nd_intel_get_security_state cmd;
>> -	} nd_cmd = {
>> -		.pkg = {
>> -			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
>> -			.nd_family = NVDIMM_FAMILY_INTEL,
>> -			.nd_size_out =
>> -				sizeof(struct nd_intel_get_security_state),
>> -			.nd_fw_size =
>> -				sizeof(struct nd_intel_get_security_state),
>> -		},
>> -	};
>> +	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
>> +			sizeof(struct nd_intel_get_security_state));
>> +	struct nd_intel_get_security_state *cmd =
>> +			(struct nd_intel_get_security_state *)nd_cmd->nd_payload;
>>   	int rc;
>>   
>> +	nd_cmd->nd_command = NVDIMM_INTEL_GET_SECURITY_STATE;
>> +	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
>> +	nd_cmd->nd_size_out = sizeof(struct nd_intel_get_security_state);
>> +	nd_cmd->nd_fw_size = sizeof(struct nd_intel_get_security_state);
> 
> Can this keep the C99 init-style with something like (untested):
> 
> _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
>               sizeof(struct nd_intel_get_security_state), {
> 		.pkg = {
> 		        .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> 		        .nd_family = NVDIMM_FAMILY_INTEL,
> 		        .nd_size_out =
> 		                sizeof(struct nd_intel_get_security_state),
> 		        .nd_fw_size =
> 		                sizeof(struct nd_intel_get_security_state),
> 		},
> 	});
> 	
> 
> ?

The code below works - however, notice that in this case we should
go through 'obj', which is an object defined in _DEFINE_FLEX().

         _DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
                         sizeof(struct nd_intel_get_security_state), = {
                 .obj = {
                         .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
                         .nd_family = NVDIMM_FAMILY_INTEL,
                         .nd_size_out =
                                 sizeof(struct nd_intel_get_security_state),
                         .nd_fw_size =
                                 sizeof(struct nd_intel_get_security_state),
                 },
         });

Thanks
-Gustavo

