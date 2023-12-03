Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B5C1
	for <linux-hardening@vger.kernel.org>; Sun,  3 Dec 2023 01:00:03 -0800 (PST)
Received: from [192.168.1.104] (31.173.83.161) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 3 Dec
 2023 11:59:53 +0300
Subject: Re: [PATCH] pstore: ram_core: fix possible overflow in
 persistent_ram_init_ecc()
To: Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	<linux-hardening@vger.kernel.org>
References: <20231105202936.25694-1-s.shtylyov@omp.ru>
 <170155004188.180877.9632245955503394490.b4-ty@chromium.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6f0ae1ff-2503-fb42-2df3-4ba2cb0edd69@omp.ru>
Date: Sun, 3 Dec 2023 11:59:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <170155004188.180877.9632245955503394490.b4-ty@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 12/03/2023 08:41:00
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181783 [Dec 03 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.83.161 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.83.161 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;git.kernel.org:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.83.161
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/03/2023 08:47:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/3/2023 7:13:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/2/23 11:47 PM, Kees Cook wrote:
[...]
>> In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
>> 64-bit value since persistent_ram_zone::buffer_size has type size_t which
>> is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
>> this value gets assigned to has (always 32-bit) *int* type.  Even if that
>> value fits into *int* type, an overflow is still possible when calculating
>> the size_t typed ecc_total variable further below since there's no cast to
>> any 64-bit type before multiplication.  Declaring the ecc_blocks variable
>> as *unsigned long* should fix this mess...
>>
>> [...]
> 
> I changed this from unsigned long to size_t, which will do the same thing.

   Not quite the same. And ecc_blocks is a block count, not a byte count, so
size_t doesn't seem appropriate...

> Applied to for-linus/pstore, thanks!
> 
> [1/1] pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
>       https://git.kernel.org/kees/c/c92116e01d32
> 
> Take care,

   Thanks anyway. :-)

MBR, Sergey
