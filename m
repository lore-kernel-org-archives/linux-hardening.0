Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B04A21;
	Thu, 16 Oct 2025 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573129; cv=pass; b=XgIU+59ebtYAXQR7qjs+NZx13vwwor/KLbBzzJrS7ZiJjMXDatym9eHBJ4cZV4lpcJGHAVmLGZzafmrqpjFU9IjavcfdxAMT7T3jzkhpESdDO4D4RwaFFjyK0F+WTh0DkzJ4KI5D1Oh9e9ho6d00Ii6EYE+MN1bGkVqJRxuOmTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573129; c=relaxed/simple;
	bh=PXIvfSkvKhjahz5IfmPNxHSzo2BHASSJSn8cbold3fg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FE8G3A2XlT30F2G4fwO4fuJvGP2GnMxFJaIKb1Ks7hoFjSf6yoTdbiucxRfgnuyDEset+h3BFu4GlrOqXkarRfx/Ra+iW5J73MeRZUBLjED1ELytAiEGeTzENRYYyanF+1vRs2XWDm0ubDLAxC9YIK+ySNNhdAXY+LJ415Em6JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=jz4PLHo+; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="jz4PLHo+"
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59G055tq057542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 Oct 2025 09:05:05 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id DBA0A10A0ECFC;
	Thu, 16 Oct 2025 09:05:04 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBj9FxykKqBa; Thu, 16 Oct 2025 09:05:01 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id F09B7109D6CBF;
	Thu, 16 Oct 2025 09:05:00 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org F09B7109D6CBF
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1760573101;
	cv=none; b=gXACnEg22hpPOwAvf4A4+BynmYgTUkX9oCkL4CMaXIYwaZ8hKHDj78LKE2Kr4T5tE8ttT5Geuoh/4Pyfu1q8DblHn7UB71IDRwmcWQvS3RCbGwCvVPHOa7tk3Hce0lpg7hYxRjlRMHscTR1oC8Wr5/Qb2/Ot0LbXbt5qBgY1vhY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1760573101; c=relaxed/relaxed;
	bh=DPaxnV9aWyZC2x6SIViSVdD5KDV9aYqC64JDt2kRang=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=BqF6R0BhP9Ce/0LI75rq/ZvaUHwtdCWdLry/01RYIhk/ZPGgBTvHDpgWC2lfz5SB08k6B4K5obbQYvLzUAL64tdrZg8lEu0vLPlb7ckbxewtCOVM+egBN5JV2wgEzVlbM/HCH2orhIkUPqE0SJ/fvBJ0eT2de8ieZN1U9vHOUeU=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org F09B7109D6CBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1760573101;
	bh=DPaxnV9aWyZC2x6SIViSVdD5KDV9aYqC64JDt2kRang=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jz4PLHo+725Ymxa8YI+Bt1qGtT32YXT5JoolE3Z1zeDR0WfqaIy5/ZSOncmb5gkdl
	 xdONBrCoimEnKCzfPVcRwJW0Ron4HlGVYZVu4E0derLh2Miw09Ezx4cnxZtB19VzXA
	 +LjiH5cplfeWjxmY52kCvqh8yjOwtPt4k0xZ6JZ8=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Oct 2025 09:05:00 +0900
From: weibu@redadmin.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        linux-doc@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin-guide: Correct styling of MS-DOS
In-Reply-To: <87o6q9bkcn.fsf@trenco.lwn.net>
References: <20250926184824.40270-1-weibu@redadmin.org>
 <87o6q9bkcn.fsf@trenco.lwn.net>
Message-ID: <5c079b842219c54faed2224b104533e2@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Jon,

You have a valid point. I agree that it's probably not worth the churn. 
Please feel free to drop this patch.

Thanks,Akiyoshi

2025-10-14 23:59 に Jonathan Corbet さんは書きました:
> Akiyoshi Kurita <weibu@redadmin.org> writes:
> 
>> "MS-DOS" with a hyphen is the official styling. Change the
>> less common "MSDOS" to "MS-DOS" for correctness and consistency.
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
>> ---
>>  Documentation/admin-guide/pstore-blk.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/admin-guide/pstore-blk.rst 
>> b/Documentation/admin-guide/pstore-blk.rst
>> index 1bb2a1c292aa..1e2abb2ef500 100644
>> --- a/Documentation/admin-guide/pstore-blk.rst
>> +++ b/Documentation/admin-guide/pstore-blk.rst
>> @@ -59,7 +59,7 @@ When pstore/blk is built into the kernel, "blkdev" 
>> accepts the following variant
>>     with no leading 0x, for example b302.
>>  #. PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF represents the 
>> unique id of
>>     a partition if the partition table provides it. The UUID may be 
>> either an
>> -   EFI/GPT UUID, or refer to an MSDOS partition using the format 
>> SSSSSSSS-PP,
>> +   EFI/GPT UUID, or refer to an MS-DOS partition using the format 
>> SSSSSSSS-PP,
>>     where SSSSSSSS is a zero-filled hex representation of the 32-bit
> 
> A quick grep shows a lot of occurrences of "MSDOS" in the kernel 
> source.
> I don't think the churn of fixing all of those is worth it...?
> 
> Thanks,
> 
> jon
