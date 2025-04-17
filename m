Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E161254B12
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907823; cv=none; b=bY+xJazFWq4mNe7W/6gD1+iwxBIEqevkq+p94EVbQGYkqPjVGPLaNCtDYXeamAw2AN3cxm/J/D+OOH608WVMV6KkqahaKIY8DbmAtkPp4dGW+zY/qibToWGYElI2AR8+f1YcmAYjigty8kBcRV/I/aqf9Plva1erSIV908eRD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907823; c=relaxed/simple;
	bh=ZB1x85E9TZSV27ACI1YbITPS8W7AaqTCmW3E93K4f0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5gixFNpXj0DkvFmEZl/Xs4dKx1jgjMkOaU1gKSwJaSvyM+H35PU/sWIiECTZxBioZSZ9vkivo/n4RhZWowD5arTWJtjFosFbsYqEG/z+W+XfILAcM7PiSgWw+gzenOtn/NvWkWmN1oAKxZreWCv54GToXEfA66lW8liyQxwrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8Ky6Pvh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8Ky6Pvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744907819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHtvPer+uhTnTZr30khXohx3R0vSZbxSNnylVoOnq58=;
	b=B8Ky6PvhY5KN0EJ9JvwsbvGtOuJ7ydjjRIsI08di9nzIJSe1Gvx+6JyDsKKUrxx3xRb7Z8
	itbWlFoEFVyUDaZMDXFgr1AEBpujReVd77bXq7Wykr27TSQuAHyaBW6L9tZmgYkZ0IKQyw
	pt4K+kbGUX+8Ibmw+JXb6Qo6aJ9LM2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-t5j63oQ2PAmH5IVFq-QmPQ-1; Thu,
 17 Apr 2025 12:36:55 -0400
X-MC-Unique: t5j63oQ2PAmH5IVFq-QmPQ-1
X-Mimecast-MFC-AGG-ID: t5j63oQ2PAmH5IVFq-QmPQ_1744907812
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6668182FF46;
	Thu, 17 Apr 2025 16:35:57 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28A21956095;
	Thu, 17 Apr 2025 16:35:52 +0000 (UTC)
Message-ID: <76f668a7-1cd6-445b-9e62-cb314bdeefa9@redhat.com>
Date: Thu, 17 Apr 2025 18:35:51 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <20250417161354.GF372032@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250417161354.GF372032@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 17. 04. 25 6:13 odp., Lee Jones wrote:
> On Wed, 16 Apr 2025, Ivan Vecera wrote:
> 
>> Registers present in page 10 and higher are called mailbox type
>> registers. Each page represents a mailbox and is used to read and write
>> configuration of particular object (dpll, output, reference & synth).
>>
>> The mailbox page contains mask register that is used to select an index of
>> requested object to work with and semaphore register to indicate what
>> operation is requested.
>>
>> The rest of registers in the particular register page are latch
>> registers that are filled by the firmware during read operation or by
>> the driver prior write operation.
>>
>> For read operation the driver...
>> 1) ... updates the mailbox mask register with index of particular object
>> 2) ... sets the mailbox semaphore register read bit
>> 3) ... waits for the semaphore register read bit to be cleared by FW
>> 4) ... reads the configuration from latch registers
>>
>> For write operation the driver...
>> 1) ... writes the requested configuration to latch registers
>> 2) ... sets the mailbox mask register for the DPLL to be updated
>> 3) ... sets the mailbox semaphore register bit for the write operation
>> 4) ... waits for the semaphore register bit to be cleared by FW
>>
>> Add functions to read and write mailboxes for all supported object types.
>>
>> All these functions as well as functions accessing mailbox latch registers
>> (zl3073x_mb_* functions) have to be called with zl3073x_dev->mailbox_lock
>> held and a caller is responsible to take this lock.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> v1->v3:
>> * dropped ZL3073X_MB_OP macro usage
>> ---
>>   drivers/mfd/zl3073x-core.c       | 232 +++++++++++++++++++++++
>>   include/linux/mfd/zl3073x.h      |  12 ++
>>   include/linux/mfd/zl3073x_regs.h | 304 +++++++++++++++++++++++++++++++
>>   3 files changed, 548 insertions(+)
> 
>> +/*
>> + * Mailbox operations
>> + */
>> +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
>> +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
> 
> Why aren't these being placed into drivers/mailbox?

I think the only common thing of this with drivers/mailbox is only the
name. Mailbox (this comes from datasheet) here is just an atomic way to
read or write some range of registers.

How can be that used here?

Ivan

