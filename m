Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4247A860
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584480; cv=none; b=QMlAf1RqFQS325OcFuK9N0WgzdERwZ/K0m3udbdaAX0kb7CuNT7K4du7ul1Ttxp9v3G2clw8moA4uxMPFjA6XuIQKowtz2yNpcThw3DbVEJFkWj4fewCdLmr2bDAEPtLyLb8A0DIofkphZW4fSnfyynUFywrIHmg7zYJ1A+lFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584480; c=relaxed/simple;
	bh=cLfeyMYlE7LALUmIDZ09d4RId2E8nj9jM9ks46yKFFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLfkee6HTw6C31D/jKoxrbDsawgS77EgiDaHqWqEno3Lseh+VL25E3AO91sehBbiB644jy6r8IjyV+zt9nLCemvF4tXifB/Y/7nhQLPdJG1t224jMNqx+hWgj4H7vHNNWBmNvnq6Q71rWfFgJ7UV70k5JA5GwFSg07e+Pj3tXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfosCRyj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfosCRyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790584477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uzwrULNhYSechUNjVS/Fi9ktEtQS2wEO+pXDyiHKO9g=;
	b=PfosCRyjLGVC+zNxoMbw+qqYeNxeHzxlHg9l65JChOwfk3GDbmlr0+iwzp9+ddQLNVp5Ee
	vPowMGA203Kkszz3VgRieGtStGwECFz4G8lsibzZ/BmITtaCsH4RgwIw+98qK638BATUHw
	bshBOHdjNZbigkzxJ/2ntjlU4VG+T9I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-RP06c6wFNB-pgySNhUUuhQ-1; Mon, 28 Sep 2026 04:34:35 -0400
X-MC-Unique: RP06c6wFNB-pgySNhUUuhQ-1
X-Mimecast-MFC-AGG-ID: RP06c6wFNB-pgySNhUUuhQ_1790584474
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48889db9974so1322879f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 01:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584474; x=1791189274;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzwrULNhYSechUNjVS/Fi9ktEtQS2wEO+pXDyiHKO9g=;
        b=Qqqp3Qyuz6fVdbsxwiQw+x1nqxL7E/K5f+KYG7vLXFJJIc1B8OmomxY9Z5rsBquouV
         1KM5pblKLFYDjGC7hGXhmDDpRVmDH7x/2qSKLYXeIAkUSo8t0DRjiH03mgiTpdzFS0/7
         mCVm87ebZhXi2MPiOPqEoTzxZZ/jIOPnCst+HxAwFrZeBKcuqU/Yp3NRliY1x3lu+5Ul
         W2dATgSYNhfi+d8FnUsvMWDB8/BQBs1dn5ea0gzP+gPyFmExDiEwi/xajOX0qPUDoo0K
         iWl8lF4T86kJ1KHR2nA/6Qym9RC5KHFMlAfq9J2QLqZOCxz38GqfRx2g/KKY0SfS7mNx
         FLEw==
X-Forwarded-Encrypted: i=1; AKwUvByx/pXGC+yYBIPoa7gyaE8jDKLar2IAClInSYHPCaqO3cKg+tsUmyCXuSOARHbWnVCMf/5nGfbKRuq/PAPFfnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn1GjXRRyDNAA1JqmHaeWFmfSczm2yhMRlzeWghwQMC163fjXb
	nWNqGyuZfpv1/kYMNduiSMDNiigBP8ZkvopKiJZ3x76IWXwECvGx1zJC2x9+wJy2Ihdv2O0J+cy
	KJMeT6TLN8HuMGTTb6k87H6A53uBYGYRnU8IoHUWQV7MskZPHSCNMuOFk7Vgqq02K60eJsw==
X-Gm-Gg: AYBFou09UloBNkXzbGQgCpRLeaqUhGVXyvaRguiD/ICcNBuds+IxHjXq9h5z9GqVl8I
	hkKxw2DmB3qjmymxpzHJMLEhGeV+3iyUHj9V7PzjoxfgZn/2lftRRdIuQjUp7X1gNcHsxJv4NDp
	nkDOkfetV7d+H8h7vW3usIRChHwhaFkME6/KxJd1MYHyCe8laVTUb+RGRgxb7e/wttBiooUaugN
	PcC8ykd9y7lBeLlCQU8J6eI60+nSKOyatSlQdpnP6b3irjVdrR6hrcpJ/P+mW3jgE6wZhchQipc
	7vT09XwDZoNWInV/67hnaKkG/9EyTEtqY0+UNHRrfym7PNRmHLKe/j4Sky4AL3WIq0YXiANq
X-Received: by 2002:a05:6000:178d:b0:488:8192:c765 with SMTP id ffacd0b85a97d-4888192c938mr18877202f8f.18.1790584474479;
        Mon, 28 Sep 2026 01:34:34 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:488:8192:c765 with SMTP id ffacd0b85a97d-4888192c938mr18877142f8f.18.1790584473923;
        Mon, 28 Sep 2026 01:34:33 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm25850940f8f.28.2026.09.28.01.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:34:33 -0700 (PDT)
Message-ID: <5a5e160c-e3ec-4142-9e19-63b49ad922c4@redhat.com>
Date: Mon, 28 Sep 2026 10:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/purgatory: Compile purgatory with -D__DISABLE_EXPORTS
To: Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260925130217.3912329-1-arnd@kernel.org>
 <20260925191635.GC2060@quark>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20260925191635.GC2060@quark>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -_4FT2xf11e10YAp4zCSMbycAt6MzdDq5O_eTzS5yEs_1790584474
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2026 21.16, Eric Biggers wrote:
> On Fri, Sep 25, 2026 at 03:01:49PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> A previous patch fixed compile-time issues by setting __NO_FORTIFY
>> for all of the purgatory code, but this is insufficient and still
>> leaves build failures that appeared recently in linux-next:
>>
>> ld.lld: error: undefined symbol: __memset
>>>>> referenced by string.c
>>>>>                arch/x86/purgatory/purgatory.ro:(__UNIQUE_ID_addressable___memset_2)
>>
>> ld.lld: error: undefined symbol: __memmove
>>>>> referenced by string.c
>>>>>                arch/x86/purgatory/purgatory.ro:(__UNIQUE_ID_addressable___memmove_3)
>>
>> Set __DISABLE_EXPORTS as well, to avoid pulling in a reference to the
>> wrong string functions.
>>
>> Fixes: 65cbe410d312 ("x86/purgatory: Compile purgatory with -D__NO_FORTIFY")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   arch/x86/purgatory/Makefile | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
> 
> I dropped the patch this fixes already, as I mentioned at
> https://lore.kernel.org/linux-crypto/20260924174911.GA1978@sol/ .  It's
> gone from linux-next now.  I think Thomas Huth is planning to send a
> fixed version, together with the two patches that depend on this.
> 
> But compiling all of purgatory (and not just sha256.o as is the status
> quo) with -D__NO_FORTIFY -D__DISABLE_EXPORTS sounds good to me.
Yes, I think that's the way to go, and I've now also verified that the 
change is working. I've now send a new version of the patch here:

  https://lore.kernel.org/lkml/20260928083055.104266-2-thuth@redhat.com/

  Thomas

