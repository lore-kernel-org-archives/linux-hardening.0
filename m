Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A6374C5
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jan 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="NIucxFSj"
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id N8N0rYygt9gG6NBysrEgjF; Tue, 09 Jan 2024 13:17:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NByrrwhMTBnVCNBysr5qbN; Tue, 09 Jan 2024 13:17:22 +0000
X-Authority-Analysis: v=2.4 cv=H+TIfsUi c=1 sm=1 tr=0 ts=659d4762
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10
 a=KyMIMFQuxE6nYXeOrGAA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8W8th+yZKgB6Mevmn0LVDH8dJPwInBnSVOM74Cudbh4=; b=NIucxFSjZdsksQtqD/B4ik/b7X
	4le4nCWZRPeDtiXniiyEF1IVbfqo1V0jvIQXBuvkUYQBejeDGWjChsd0GzXCRLYgw2L7B57PllHIC
	OmehgBJ9416OGScpIWphGWJmzkVR7bGlZBcYkUA5NxUuxSb9I6wDeOCFunKlRBtabfFkmzxxzhDRD
	tHAoqtBAGB3O4Ggv+CaMZcZ+L/6Kri2s7ESHPH6ePLs0iRUuu7HM1VEtR3Dnf+UbOCu2HhRtTfFak
	qAqmalmO+B4tiy3pN5Q4YHjBZMVKCjTvPAc710z7KSdLuH4wqzq+UhxH+BHF0BlOudBCxtYM2MAyr
	vuL4b5DQ==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:21168 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rNByp-003VuY-38;
	Tue, 09 Jan 2024 07:17:20 -0600
Message-ID: <b8686724-9351-4f40-a587-fcbba5b0eb14@embeddedor.com>
Date: Tue, 9 Jan 2024 07:17:16 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace one-element array
 with flex-array member and use __counted_by
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZSRJfRdUXQOzagKr@work> <202310091252.660CFA9@keescook>
 <20240109124026.GA1012017@google.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240109124026.GA1012017@google.com>
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
X-Exim-ID: 1rNByp-003VuY-38
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:21168
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOQDlhBsVa1RJkkz6ctbxoJ2hU/dyxQsHyfqUvqqN4zh16IiBCzahYFivao51GjJ0/IbNTYjmmcU1GpyqNf0k5VKyEwVkUiRYWkb7xcsEw1ptAv6JgHr
 yVY/Toa/k7MGWHiQp2ZTHw4ewEYfca9qlxn2A5MascwfjcD6lGNIOiaMjVTPOzCM84m0h+tplf/mPTrpOTo0Dv+yDKQOlSQrwQbiMNbe0849iF1GkOmVZNyc


> Sorry for shameless plug, a quick question: has any compiler implemented
> support for counted_by() at this point?
> 

Not yet. And at least for GCC, it's expected to be released in v15.

Thanks
--
Gustavo
