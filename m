Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D4E31A79
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jan 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="lGDjosfX"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id Lkkir6XCaCF6GLnjYrylXE; Fri, 05 Jan 2024 17:11:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id LnjXrsuROZKctLnjXrWJZF; Fri, 05 Jan 2024 17:11:47 +0000
X-Authority-Analysis: v=2.4 cv=a+kjSGeF c=1 sm=1 tr=0 ts=65983853
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=4RBUngkUAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=mMSqsx3Zob4kaL-hISMA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6PntA5ZaDik4lP4pysMJLZ/4nGEXSTiIJkbgJTJZUUQ=; b=lGDjosfXk8Xnb+BnepzYP4H0k8
	8ia2YZm8+9ajYyC3etP9/zyp4sBZHZhpbJNHyGNzVoGpbSWQFslgT4WbxjAO9AiPcxQ2pVsOsrflX
	uGtAHrmaFsw+DJdAhB8dANSwonDtRtyXgBd1+UZZMyC+1cRQAT+JBnO6n9/pqNAjpTuh/qAwn1jOz
	ZsB60lekasrXpW4sOC36Y4PRbTtbI2So9bNzXabsM1ZwvA+z+VSWtZ5C86hF08FtsoIwIx8+hp67S
	817HbyCc60YDIeszk361QcCHsIQGypzOSaSNJtNZ1mVACtRC+5ZKOQ84G9xxSoobTsxaVU6E8ZbDV
	IKxYWNnQ==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:15142 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rLnjW-0027K1-19;
	Fri, 05 Jan 2024 11:11:46 -0600
Message-ID: <bfa368ff-f9b0-4944-9988-96438b965299@embeddedor.com>
Date: Fri, 5 Jan 2024 11:11:42 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hardening@vger.kernel.org, keescook@chromium.org, error27@gmail.com,
 gustavoars@kernel.org, Bryan Tan <bryantan@vmware.com>,
 Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: vegard.nossum@oracle.com, darren.kenny@oracle.com,
 syzkaller <syzkaller@googlegroups.com>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rLnjW-0027K1-19
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:15142
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfANkkUo8JanvRB0oWyfuPz/j2P5FaPRPnTKL/svgQqntKn/Ub0JFFNCbECVNHWz4/TqyESLwRfqYaQUIWgq7VUlvaO0OwB0bQNZaKrzRNBxNwl+2yiCc
 7V99WkINbQ8DpscCWiungUyLd1M+2FTcGd+AXRqP/Ewba7Qvt66vjJ+AdGyZh9IRTpWdSCESM+MiUviKrA8LeubPO1Sd0zuEgOgugLwtPLuAmdobo2YpgnJr



On 1/5/24 10:40, Harshit Mogalapalli wrote:
> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> 
> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> 
> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> 
> Some code commentry, based on my understanding:
> 
> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> /// This is 24 + payload_size
> 
> memcpy(&dg_info->msg, dg, dg_size);
> 	Destination = dg_info->msg ---> this is a 24 byte
> 					structure(struct vmci_datagram)
> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> 	Size = dg_size = 24 + payload_size
> 
> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> 
>   35 struct delayed_datagram_info {
>   36         struct datagram_entry *entry;
>   37         struct work_struct work;
>   38         bool in_dg_host_queue;
>   39         /* msg and msg_payload must be together. */
>   40         struct vmci_datagram msg;
>   41         u8 msg_payload[];
>   42 };
> 
> So those extra bytes of payload are copied into msg_payload[], a run time
> warning is seen while fuzzing with Syzkaller.
> 
> One possible way to fix the warning is to split the memcpy() into
> two parts -- one -- direct assignment of msg and second taking care of payload.
> 
> Gustavo quoted:
> "Under FORTIFY_SOURCE we should not copy data across multiple members
> in a structure."
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
> This patch is only tested with the C reproducer, not any testing
> specific to driver is done.
> 
> v1->v2: ( Suggestions from Gustavo )
>          1. Change the commit message false positive --> legitimate
>             warning.
>          2. Remove unneeded payload_size variable.
>          3. Replace first memcpy() with direct assignment.
> ---
>   drivers/misc/vmw_vmci/vmci_datagram.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
> index ac6cb0c8d99b..ba379cd6d054 100644
> --- a/drivers/misc/vmw_vmci/vmci_datagram.c
> +++ b/drivers/misc/vmw_vmci/vmci_datagram.c
> @@ -234,7 +234,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
>   
>   			dg_info->in_dg_host_queue = true;
>   			dg_info->entry = dst_entry;
> -			memcpy(&dg_info->msg, dg, dg_size);
> +			dg_info->msg = *dg;
> +			memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
>   
>   			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
>   			schedule_work(&dg_info->work);
