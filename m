Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DD2F618D
	for <linux-hardening@vger.kernel.org>; Sat, 20 Dec 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766214773; cv=none; b=maJ9w73I+VSDxT1D/15OHiZGgZet62vPRNCYxEjKyct/cR6KUI6P24AE795orPNnnZTOR8hKHzgvO1giWlYGdex5p5EOESdoQGXPoW+y55DlzYSJfGxoK/LialUru1n4P55RO/F7VDLFu1eU/BakQG076g6K8TpORrjz25NNYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766214773; c=relaxed/simple;
	bh=WPMO3B2heEngDGPZXTvUi5d9N9T47ScEsGe5CAP7NVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLg5FBa1r+PUoVsB8q8a3TJTpPORC3KOZetD6/lnlop0Sx4YR2zFQvOOZi1WXBEIWQACSGC+T/gNYWs5bR2ch4ky6ABwjWxva32A41xz8t3bZFiZGUUB3qROxaVQuWQz2uvtITS2TLSHfxo+jfVuCQgXeGmGVjevqK9eYLzQy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=npYhtjZP; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="npYhtjZP"
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id WqEVv9tktVCBNWr8uvn1eK; Sat, 20 Dec 2025 07:12:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Wr8tvIFedPL32Wr8tvfgrv; Sat, 20 Dec 2025 07:12:43 +0000
X-Authority-Analysis: v=2.4 cv=MqhS63ae c=1 sm=1 tr=0 ts=69464c6b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=DfK0_ZNNswAGoXOUU8MA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n1Zq/KZ9c9/IpwF7BqDD4sGMIcr8Lqe8exdAPZLEG84=; b=npYhtjZPM4YDM//6yNLsz9nxjd
	uuUToOf3Fg27jdf1T3OAC1nIL3vh/PRBsKq6h5apacClDHdHbhOzWgdKULNJb4WpsTQB1Vu0yP1YZ
	kDfle+VkCHzEfY8pS60ppGfN5K/GRcufwrzWWnqNQMLqaoxPHPj/VYitAIMN4IcpRidDBm07FCKfq
	TX2rozqEbiy8vpe9N2HhVWk/xGhH+LUDLlcCwe6drrZ4j9VmJMjeXP/S1v+Ky2JeW4vCuAiFr6Q/5
	SdY02XZSJjkajJUvLp0fa6lMSibcZbsCP8efuVpSig0/pKIYbj3vBve4fDl0w/5aNXw5gwk7faf9h
	7wcaKqIw==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:60170 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vWr8r-00000002tT6-3vUy;
	Sat, 20 Dec 2025 01:12:42 -0600
Message-ID: <c8190aae-25d8-469d-8efa-6d1ff9482347@embeddedor.com>
Date: Sat, 20 Dec 2025 16:12:33 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
To: Raag Jadav <raag.jadav@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tomas Winkler <tomasw@gmail.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aUZFLezigzZQVt55@kspp> <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vWr8r-00000002tT6-3vUy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:60170
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNRcF0vBcb7RqzVV07bJXqEG6RZM7MhI2LCRJl+NUCRNHgnjqg9Kv6EUgs52HHUTJcdB6M745V/U8qJIVmCMWtsQMuR0nDV0JcoarSnEkPZFZxG6kP+V
 W23hPCW39VzGPxLZ6I8h0DbBCVEhMyU/Tf7CZ8ndlt0kz+GtcIzMQlDGnvdADW2BlBI1DGBkWF6PpVmM3T92MZiIBqVUhsGURAmdYTJAN0atWDrHUYTFcsDO



On 12/20/25 16:07, Raag Jadav wrote:
> On Sat, Dec 20, 2025 at 03:41:49PM +0900, Gustavo A. R. Silva wrote:
>> Fix the UBSAN: array-index-out-of-bounds issue below by updating
>> counter nvm->nregions before the first access to flexible-array
>> member nvm->regions[].
>>
>> from kernel bugzilla:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220823
>>
>> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
>>
>> Notice that this flexible array is annotated with the counted_by()
>> attribute, hence the counter must always be updated before the
>> first access to the array.
> 
> Already fixed[1], but not sure if it's landed yet.
> 
> [1] https://lore.kernel.org/linux-mtd/20251111-mtd-nregions-v1-1-61db61e78c63@intel.com/

Great! :)

Thanks
-Gustavo

