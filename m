Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88E219E8D
	for <linux-hardening@vger.kernel.org>; Mon,  9 Feb 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675801; cv=none; b=pXhWQGJB7kYcnF9tptoZ1WDjWQmX/HIbZjiPTurLHqlAjoR13623fHg01VRR3WfdPZJ20kYsww7K420c/qXMFWW6NoDdl9Etxws7Iu+K/veL45cO1TKhNRdpKlw0mQRURdFDa6p2nericx2GBG6nJ44Jt2sAzWACXxZVWhOHUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675801; c=relaxed/simple;
	bh=E/wDNYT8yd4LvpoBYJ5ZjInPsfE0jSS1jaxSdU49C18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teppT1r+PacgGPj1d6yYc9M6k2i5EXZHTmMAw2v7PyPHdXObwfDUupmdzPZ6vTc92SFoLD/Uubz4OXQEwhSF9IdKVeXiIneBB1+6xXoMv13OepMuxuT1rGgas/G98yrFDT/fkorbeHqP/sh4PheiMi7CeGoFcb1QBW/YqSliI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nl/9NeqK; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nl/9NeqK"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id pWb4vFbBNKXDJpZf5vFypN; Mon, 09 Feb 2026 22:23:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pZf5v4Y6p2l0kpZf5vD0d5; Mon, 09 Feb 2026 22:23:19 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=698a5e57
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Mt98uAL8hC94oX8DrwaRjw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7T7KSl7uo7wA:10
 a=IdIfsTrEsfU7E6sfyFMA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SHn36UqCLpdD2vGFlZTVJyUtylTSL6ZnEIe6tsgs8Og=; b=nl/9NeqKjijtQ/ICGi1t4Ju80B
	4pEyYHFHFdDnjoUit+2i+Ge71Bljcf9oNy2lXAJuEk/EkM70KnEXzHiexmp7rNcxlXMTpJe9EQ93a
	KDHEYVyvCEPxazb5a6lG6G8+HFP8dFWmvqCXPXWog6YfDg8FOOM5inMEuylQ173RqrekdWpH3uoP0
	gYrlS01dKMAropBI+V3qHjIlbKQx1lUEgJruDZiuxaFuyk4+s4gAjOKR/LWU4IlSBXL7tN7vWigMw
	PA233sVfnhtvDvGy4SdFwUW4Al+8LKUEO34ikdlu4U9Iij9KdknGDagJWkYFa9TowyNbZxHMB/H1B
	+DZcjU2w==;
Received: from [177.238.18.130] (port=51670 helo=[192.168.0.100])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vpZf4-00000003cd5-2I7f;
	Mon, 09 Feb 2026 16:23:18 -0600
Message-ID: <cc8b81d0-8bfb-4b69-8c48-9224c3bf6b97@embeddedor.com>
Date: Mon, 9 Feb 2026 16:22:44 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stanislaw Gruszka <stf_xl@wp.pl>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aYlkt2WP2oQ1TgeH@kspp> <202602091212.743C6B9B7C@keescook>
 <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
 <202602091416.A7FD08F6C@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202602091416.A7FD08F6C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.130
X-Source-L: No
X-Exim-ID: 1vpZf4-00000003cd5-2I7f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.100]) [177.238.18.130]:51670
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPUqHg7nQfItJ6njcHX8ufuxFv2hcorPz9BUzUzx8dZ5B3TX3oc5iX3YdVG7AD1bkmVaVIG4Ji8Cig5ZBeeIiELCutPQdhxEDuIe3anX9bYXZKlZSW0x
 Bl5RVuqlP6C5iSuYsR83DhhzKNRdXjvGbey04iwANEE+1jtHaiHCnR0R8bLZvUaEw5o7BMMmOXKsHvuV4Z0xudOGod8x0N5E/8fQ64RkisY417SV6fmkbMUb



On 2/10/26 07:20, Kees Cook wrote:
> On Mon, Feb 09, 2026 at 03:23:59PM +0900, Gustavo A. R. Silva wrote:
>> Ah yes, I can do this. The only thing is that I'd have to change every
>> place where members in struct il4965_tx_resp are used, e.g.
>>
>> s/frame_count/hdr.frame_count
> 
> Hm? No, that's what transparent struct members avoid: there is no
> sub-struct name, the members of the struct are transparently visible in
> the surrounding struct:

Ah yes, that's why it's defined like

+struct il4965_tx_resp {
+	struct il4965_tx_resp_hdr;

  	/*
  	 * For non-agg:  frame status TX_STATUS_*
@@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
  } __packed;

and not like

+struct il4965_tx_resp {
+	struct il4965_tx_resp_hdr hdr;

  	/*
  	 * For non-agg:  frame status TX_STATUS_*
@@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
  } __packed;

> 
> struct inside {
> 	int a;
> 	int b;
> };
> 
> struct foo {
> 	struct inside;
> 	int c;
> } *p;
> 
> "p->a" is valid.

Yes, gotcha!

> 
>> Another thing to take into account (fortunately, not in this case) is
>> when the FAM needs to be annotated with __counted_by(). If we use a
>> separate struct for the header portion of the flexible structure, GCC
>> currently cannot _see_ the _counter_ if it's included in a non-anonymous
>> structure. However, this will be possible in the near future, correct?
> 
> Right, that's still in progress. I don't expect it soon, though. :(
> 

Okay.

-Gustavo

