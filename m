Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2078DDCD
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193781; cv=none; b=kXdqnxZF/RLCXwA9+GCo6EsuR6g2Qme+u19+0V+4oOPQb2XLIKATH9xuNbD6jNLJxWJKM6LmXQJ2vQ/nZqPnQncqc4Tf4H8jwFxtWwNEfBjnb53X5znetpo4Gk+yahF4HA8dgi+BUirTfKvKnSHEbl8FBwleCSdW98wMmtJz8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193781; c=relaxed/simple;
	bh=jMDBRsPaOHcFhnUw/Wv69LKyrOF6jC1i9MALjXLdOoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFKcmwVgBWdLDKzY6Bp3GlU5opTBb2dRCJT9wzmmNwGpbGhDrvlyfonj4nc6zNHTrf69g2xFLxM2AopeexX9fmh28Z4y2uBTKeonUf+U34+QqksheQLUZ2dqIdvzzaYsf8QazPHZ57Fq+l9PjdOJTou1BA5HOqJLg3gahrpJ62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=y5uVgPnL; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="y5uVgPnL"
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id dErKtsTJRWuHKdHbQtilWX; Wed, 29 Jan 2025 23:36:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id dHbPtP1wuvt5YdHbPtplHS; Wed, 29 Jan 2025 23:36:11 +0000
X-Authority-Analysis: v=2.4 cv=c9JgQg9l c=1 sm=1 tr=0 ts=679abb6b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=3GLQtCDrk5mhnYkuwPoHkA==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=TBnyChJfKI2p-A7FU4wA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cqLhnexwQeVTpKw6kDdMPge95PVCfboLdmw4Sd7tyBk=; b=y5uVgPnL5JZOF2lNG0FIwzQT+T
	wO8/rTfUJcpIjRMoKUxPvIzfZ9FeKJcpLnxSy7MBADV4G6F4UkX5QAWrrTcUlXQF7qa0qeTk6OCnI
	WZqVihVPlZ14gzu82uRKI7/statE0rUTjJ2ToNs/wCuY/MLZDdBTfA/x7btNfvVLkHQdwwUp2wNoh
	bbUz1NZyosiBeOMRqZp2MUtVYkCrf87JwjzXAHk7l+lKz/uzM345nykQ9Ouw27xogIayyMetK5UwY
	LTrHwU3bXDkh1/n5iyqnEY+vuz/OnKiaRwjKphtLcy46ztUwjGn3jrufLIyGN50kXRR0X9VOP3dtH
	AeDrHw4Q==;
Received: from [45.124.203.141] (port=55136 helo=[192.168.0.153])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tdHbO-003ScQ-2D;
	Wed, 29 Jan 2025 17:36:10 -0600
Message-ID: <7f165e66-a0ff-48e2-a3f3-d5405a66c867@embeddedor.com>
Date: Thu, 30 Jan 2025 10:06:00 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
To: Greg KH <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
 <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
 <2025012951-plenty-clang-1e2b@gregkh>
 <3979f87d-b7d7-48bb-b6ab-cd8165dbc3cc@stanley.mountain>
 <2025012940-hardhat-usual-fbc6@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2025012940-hardhat-usual-fbc6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.141
X-Source-L: No
X-Exim-ID: 1tdHbO-003ScQ-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.153]) [45.124.203.141]:55136
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGczMq/qww+IZfjbJLdq1kF9Tr1Vn7fgGpOrKFu8+Nxl93KhvQ+A+p9c9AmKLHqdsmFob8mpaLfd9wLWAEeOqfgNjs+be2tyyltzVRl+OODMzUzFsIOf
 cql/JsB1MlLwQSov5HJjI/5vK4+FcfWU+Bb5E37bVf9UF6vs8couWhFo3npL7rmjJTSH968LaRJUyrLt19QlzGmZBJzsI4KQcsETH7o3XhP4kBfeOpO+PdAr



On 30/01/25 02:38, Greg KH wrote:
> On Wed, Jan 29, 2025 at 05:06:54PM +0300, Dan Carpenter wrote:
>> On Wed, Jan 29, 2025 at 02:14:14PM +0100, Greg KH wrote:
>>> On Wed, Jan 29, 2025 at 01:39:27PM +0300, Dan Carpenter wrote:
>>>> On Wed, Jan 29, 2025 at 09:34:07AM +0100, Greg KH wrote:
>>>>> On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
>>>>>>
>>>>>>
>>>>>> On 29/01/25 16:24, Greg KH wrote:
>>>>>>> On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
>>>>>>>> This is like container_of_const() but it contains an assert to
>>>>>>>> ensure that it's using the first member in the structure.
>>>>>>>
>>>>>>> But why?  If you "know" it's the first member, just do a normal cast.
>>>>>>> If you don't, then you probably shouldn't be caring about this anyway,
>>>>>>> right?
>>>>>>
>>>>>> This is more about the cases where the member _must_ be first in the
>>>>>> structure. See below for an example related to -Wflex-array-member-not-at-end
>>>>>
>>>>> That's fine, but that's a build-time issue, you should enforce that in
>>>>> the structure itself, why are you forcing people to remember to use this
>>>>> macro when you want to use the field?  There's nothing preventing anyone
>>>>> from using container_of() instead here, and nothing will catch that from
>>>>> what I can tell.
>>>>
>>>> The new definition has a static_assert() in it so it's enforced about
>>>> build time.
>>>
>>> Yes, but that forces you to "know" to do that in the .c file.  How do
>>> you know to use this, and if you remove it or change it to
>>> container_of(), it works just fine again.
>>>
>>
>> I guess my use case is different from Gustavo's.  For him, using
>> container_of() is fine.  We probably don't even need an assert because
>> once you see a struct_group_tagged() then you know the order is important.
> 
> Who knows this?  The developer?  What are they supposed to "know" here?
> I sure don't :)
> 
> Having some sort of "__must_be_first" marking for a field is fine and
> break the build if that doesn't happen.  Otherwise this is something
> that is not going to be used properly over time.

I'm currently dealing with this situation in the following way:

  struct libipw_hdr_3addr {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	__le16 seq_ctl;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(libipw_hdr_3addr_hdr, hdr, __packed,
+		__le16 frame_ctl;
+		__le16 duration_id;
+		u8 addr1[ETH_ALEN];
+		u8 addr2[ETH_ALEN];
+		u8 addr3[ETH_ALEN];
+		__le16 seq_ctl;
+	);
  	u8 payload[];
  } __packed;
+static_assert(offsetof(struct libipw_hdr_3addr, payload) == sizeof(struct libipw_hdr_3addr_hdr),
+	      "struct member likely outside of __struct_group()");

"We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes." [1]

We could probably create struct_group_first() instead of container_first().

Anyways, so far so good.  For some reason I was under the impression
that you two guys wanted the container_first() macro.

OK, that's it from my side.

Have a good one!
-Gustavo

[1] https://git.kernel.org/linus/089332e703b681c8

> 
>> For me, it's code like I mentioned which does:
>>
>> 	p = container_of();
>> 	if (IS_ERR(p))
>> 		...
>>
>> And I did see you suggest that people re-write that kind of code, but no
>> one is going to do that.  :P  People know that container_of() is just a
>> cast in that case.  It works fine.  It's just a bit ugly.
> 
> It doesn't work if the field isn't first, so no, it shouldn't be working
> fine, and that should be flagged and fixed and never allowed to come
> back again.  Can't we do that with coccinelle?
> 
> thanks,
> 
> greg k-h
> 

