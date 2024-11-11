Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FE156C6F
	for <linux-hardening@vger.kernel.org>; Mon, 11 Nov 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363787; cv=none; b=cKxD17fnMR2IdQNAuSqrTNRhZlARDCEoFZMBhy/GQtvro2ooKpSUisNDce8wq51Gq1lL1gBJKAi3PeO+Wewaxc+x/cjG4/p47/i8cjQGJ6crJVUGIcZaVeQW0B3gcvjpnpINtrxmbWtASX5i4RkRl2fYrs9Wez9ATfTakupSPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363787; c=relaxed/simple;
	bh=oEkq5JQuZ0g+PteOabUnceUzJjXO3FWbvb0iXjHZDpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3wGtffOrmwwMpwxj7ku0qoQLxz45MKMt7D5Zgm1h7E2/47bRvoxXymluJMpl4gYVOT8dSrOPP6UVzTe+a0INFZ2ISwezurQyeGMtTZ8R5eYaoWQi9Zh3nmGwJ9rGDCFC2xx73u+xLtosgSWniSS+7GvO4LGswWDJdhwgTn9aWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=bdJ5RNfd; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="bdJ5RNfd"
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id AbEktZKwBg2lzAcoFt5V41; Mon, 11 Nov 2024 22:22:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AcoEtsIlwcEKuAcoFtOiya; Mon, 11 Nov 2024 22:22:59 +0000
X-Authority-Analysis: v=2.4 cv=Z7YnH2RA c=1 sm=1 tr=0 ts=673283c3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10
 a=vVgwA9Hib2JlT8r2P8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QuuLV8RyuuVn5LsdO/A41b5qscG32jUw1xdRZuRx+yg=; b=bdJ5RNfduZCRpxWEX6hIqSthKH
	FTrrIIZTFqrF5L1x6K8hpRT2ePufSi0hTV+ZvVn7Hu2iwPJsIny4fU3k9NnazJIltpgU+RnjCf8lh
	4V8sqkmVATnc14qcYUH4wDC0yuL0VqRPoyinpwa0tBF6g7fas+g4K9seXUJt5GdTLZ+lyvH2L5vOr
	uRpfWWIxhtPZmVFpaUND1UH9U5X03mf7jZW6ZfKeABx6TwirDJO2jqcvv5mI96xYT79AQzqjiW8f7
	9QX2R35vsLfgem1jEXapJBYlYcvl37s9uVkZNi2Xov+k/q0nctJrNDP5ApNxSsR8k/wBSPCNj+NV7
	4rz8BzeA==;
Received: from [177.238.21.80] (port=27680 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAcoC-001lqJ-2Y;
	Mon, 11 Nov 2024 16:22:56 -0600
Message-ID: <d4f0830f-d384-487a-8442-ca0c603d502b@embeddedor.com>
Date: Mon, 11 Nov 2024 16:22:53 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
To: Jakub Kicinski <kuba@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
 <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
 <20241109100213.262a2fa0@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241109100213.262a2fa0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tAcoC-001lqJ-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:27680
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLBQs8Ssp0xdKGXPNOx0Rd9lo62P67RLpYcCGugCKj7s7W2syR70kqqmf14ZJleRuMHo5KkUFg3fW9FyJU30pPLQwuwPUyKil/Q9UQZ4duWXOJJvNGHU
 o4HoKfvTsdrVxXZZ8Cffo7O9eIA1lYw+KVmhBngTIu5J0XX/pmgGNrvV2zjoNn1L84XOOCgd1VGxVq8cajXNqDvHCIooshHAwsnsfF/L817fzsojljGXS7EI



On 09/11/24 12:02, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
>> Use the `__struct_group()` helper to create a new tagged
>> `struct ethtool_link_settings_hdr`. This structure groups together
>> all the members of the flexible `struct ethtool_link_settings`
>> except the flexible array. As a result, the array is effectively
>> separated from the rest of the members without modifying the memory
>> layout of the flexible structure.
>>
>> This new tagged struct will be used to fix problematic declarations
>> of middle-flex-arrays in composite structs[1].
> 
> Possibly a very noob question, but I'm updating a C++ library with
> new headers and I think this makes it no longer compile.
> 
> $ cat > /tmp/t.cpp<<EOF
> extern "C" {
> #include "include/uapi/linux/ethtool.h"
> }
> int func() { return 0; }
> EOF
> 
> $ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
> In file included from /usr/include/linux/posix_types.h:5,
>                   from /usr/include/linux/types.h:9,
>                   from ../linux/include/uapi/linux/ethtool.h:18,
>                   from /tmp/t.cpp:2:
> ../linux/include/uapi/linux/ethtool.h:2515:24: error: ‘struct ethtool_link_settings::<unnamed union>::ethtool_link_settings_hdr’ invalid; an anonymous union may only have public non-static data members [-fpermissive]
>   2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs */,
>        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> I don't know much about C++, tho, so quite possibly missing something
> obvious.

We are in the same situation here.

It seems C++ considers it ambiguous to define a struct with a tag such
as `struct TAG { MEMBERS } ATTRS NAME;` within an anonymous union.

Let me look into this further...
--
Gustavo

