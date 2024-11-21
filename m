Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67C1C07D3;
	Thu, 21 Nov 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222312; cv=none; b=c3jrRErQMK+ClMqzNZx1tpldAG79HJdzG13Vq/qYfw/4arO9rh7xhRL2Vr4tqY9aWIQ0uVBiiT1AeCFVvjZnFpRTfje35e3qbT60BbP97Br7qXGtE9S3SeBQJtSb6qG0s5vpG8OKvBw0qtucU9wZIpI2shNL9i3MQqgxAEFTc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222312; c=relaxed/simple;
	bh=taT9ePeQrxhiHDut79dVzLrgGpr1nEZJDb/ox09Aocs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXVhKkd52/fySjIVPUUsFoRoEAKU34DoHjE3lU5GDtxLMHDxKT5vslge1/3d6VoQpCAeTG89ZbpjSPc43KGu3uv0pJiMpzF21owO6KDRM8IB7+CTAw85wa9CFBTxlaw1XF05QVn4lohNBWs3qN5nWuTEds99CAXFarMj7owdnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KpnQ65JT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KpnQ65JT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732222310; x=1763758310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taT9ePeQrxhiHDut79dVzLrgGpr1nEZJDb/ox09Aocs=;
  b=KpnQ65JTltTHjUcr7KH+HlGGzHUeWERuhw9LyckEcY/gOSe7WJ/HO86V
   fB3U/GLTz3gxs/Lxy7giGwbTa0vQ8RGqwcPshIVrwXsDzS54HSeM71bPU
   tMj0F5Xa2n3zqnegDd5A6sCcgrA8DsfcXUyR7VsAtVZjz58X8dI3b6jmp
   KMqU4GJdp3K5MI+etRr1L6exs2ucChWDsfFnNc/Sgwb5MnPiI2fcpxdBf
   kbeX0odIeILF/3rXXaM6ToHC+MSSv/30zSxSJhBJdWlhM9whwCXpRjpli
   vWOsWH8aba/vhquhPWB3ot7ZaO7CcK7IjAric1PHSwZJo8vuiE3c/nd12
   g==;
X-CSE-ConnectionGUID: ohIYHGjWT9G4TIF5Gcy4JQ==
X-CSE-MsgGUID: sp2A029VSRiFlo74oiLmUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32508676"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32508676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 12:51:50 -0800
X-CSE-ConnectionGUID: uDyqpQcJSv64qC4vtqakSQ==
X-CSE-MsgGUID: Z0WAiq0sRcacnmPMNs7c/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90009499"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2024 12:51:47 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEE9R-0003LD-17;
	Thu, 21 Nov 2024 20:51:45 +0000
Date: Fri, 22 Nov 2024 04:51:39 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>, Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <202411220409.0vrV1mjl-lkp@intel.com>
References: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/hardening]
[also build test WARNING on kees/for-next/pstore kees/for-next/kspp linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/overflow-improve-size_add-mul-for-32bit-systems/20241121-124847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/ebdae636-11f3-4f02-a158-f15bbed2847f%40stanley.mountain
patch subject: [PATCH] overflow: improve size_add/mul for 32bit systems
config: arm-randconfig-004-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220409.0vrV1mjl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220409.0vrV1mjl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220409.0vrV1mjl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/cdev.h:8,
                    from include/linux/tty_driver.h:9,
                    from include/linux/tty.h:9,
                    from drivers/tty/serial/atmel_serial.c:12:
   drivers/tty/serial/atmel_serial.c: In function 'atmel_prepare_rx_dma':
>> drivers/tty/serial/atmel_serial.c:1214:36: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'long unsigned int' [-Wformat=]
    1214 |                 dev_dbg(port->dev, "%s: mapped %zu@%p to %pad\n", __func__,
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:139:49: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                 ^~~
   include/linux/dev_printk.h:171:40: note: in expansion of macro 'dev_fmt'
     171 |         dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                        ^~~~~~~
   drivers/tty/serial/atmel_serial.c:1214:17: note: in expansion of macro 'dev_dbg'
    1214 |                 dev_dbg(port->dev, "%s: mapped %zu@%p to %pad\n", __func__,
         |                 ^~~~~~~
   drivers/tty/serial/atmel_serial.c:1214:50: note: format string is defined here
    1214 |                 dev_dbg(port->dev, "%s: mapped %zu@%p to %pad\n", __func__,
         |                                                ~~^
         |                                                  |
         |                                                  unsigned int
         |                                                %lu


vim +1214 drivers/tty/serial/atmel_serial.c

34df42f59a6022 Elen Song          2013-07-22  1177  
34df42f59a6022 Elen Song          2013-07-22  1178  static int atmel_prepare_rx_dma(struct uart_port *port)
34df42f59a6022 Elen Song          2013-07-22  1179  {
34df42f59a6022 Elen Song          2013-07-22  1180  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
c24d25317a7c6b Radu Pirea         2018-07-13  1181  	struct device *mfd_dev = port->dev->parent;
34df42f59a6022 Elen Song          2013-07-22  1182  	struct dma_async_tx_descriptor *desc;
34df42f59a6022 Elen Song          2013-07-22  1183  	dma_cap_mask_t		mask;
34df42f59a6022 Elen Song          2013-07-22  1184  	struct dma_slave_config config;
34df42f59a6022 Elen Song          2013-07-22  1185  	struct circ_buf		*ring;
ec9fc2cffa8d2f Christophe JAILLET 2023-11-19  1186  	struct dma_chan *chan;
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1187) 	int ret;
34df42f59a6022 Elen Song          2013-07-22  1188  
34df42f59a6022 Elen Song          2013-07-22  1189  	ring = &atmel_port->rx_ring;
34df42f59a6022 Elen Song          2013-07-22  1190  
34df42f59a6022 Elen Song          2013-07-22  1191  	dma_cap_zero(mask);
34df42f59a6022 Elen Song          2013-07-22  1192  	dma_cap_set(DMA_CYCLIC, mask);
34df42f59a6022 Elen Song          2013-07-22  1193  
ec9fc2cffa8d2f Christophe JAILLET 2023-11-19  1194  	chan = dma_request_chan(mfd_dev, "rx");
ec9fc2cffa8d2f Christophe JAILLET 2023-11-19  1195  	if (IS_ERR(chan)) {
ec9fc2cffa8d2f Christophe JAILLET 2023-11-19  1196  		atmel_port->chan_rx = NULL;
34df42f59a6022 Elen Song          2013-07-22  1197  		goto chan_err;
ec9fc2cffa8d2f Christophe JAILLET 2023-11-19  1198  	}
ec9fc2cffa8d2f Christophe JAILLET 2023-11-19  1199  	atmel_port->chan_rx = chan;
34df42f59a6022 Elen Song          2013-07-22  1200  	dev_info(port->dev, "using %s for rx DMA transfers\n",
34df42f59a6022 Elen Song          2013-07-22  1201  		dma_chan_name(atmel_port->chan_rx));
34df42f59a6022 Elen Song          2013-07-22  1202  
34df42f59a6022 Elen Song          2013-07-22  1203  	spin_lock_init(&atmel_port->lock_rx);
34df42f59a6022 Elen Song          2013-07-22  1204  	/* UART circular rx buffer is an aligned page. */
2c277054104031 Leilei Zhao        2015-02-27  1205  	BUG_ON(!PAGE_ALIGNED(ring->buf));
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1206) 	atmel_port->rx_phys = dma_map_single(port->dev, ring->buf,
12bedddb67520d Jiri Slaby (SUSE   2024-04-05  1207) 					     ATMEL_SERIAL_RX_SIZE,
48479148a2f531 Wolfram Sang       2014-07-21  1208  					     DMA_FROM_DEVICE);
34df42f59a6022 Elen Song          2013-07-22  1209  
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1210) 	if (dma_mapping_error(port->dev, atmel_port->rx_phys)) {
34df42f59a6022 Elen Song          2013-07-22  1211  		dev_dbg(port->dev, "need to release resource of dma\n");
34df42f59a6022 Elen Song          2013-07-22  1212  		goto chan_err;
34df42f59a6022 Elen Song          2013-07-22  1213  	} else {
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05 @1214) 		dev_dbg(port->dev, "%s: mapped %zu@%p to %pad\n", __func__,
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1215) 			ATMEL_SERIAL_RX_SIZE, ring->buf, &atmel_port->rx_phys);
34df42f59a6022 Elen Song          2013-07-22  1216  	}
34df42f59a6022 Elen Song          2013-07-22  1217  
34df42f59a6022 Elen Song          2013-07-22  1218  	/* Configure the slave DMA */
34df42f59a6022 Elen Song          2013-07-22  1219  	memset(&config, 0, sizeof(config));
34df42f59a6022 Elen Song          2013-07-22  1220  	config.direction = DMA_DEV_TO_MEM;
34df42f59a6022 Elen Song          2013-07-22  1221  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
34df42f59a6022 Elen Song          2013-07-22  1222  	config.src_addr = port->mapbase + ATMEL_US_RHR;
a8d4e016379023 Ludovic Desroches  2015-04-16  1223  	config.src_maxburst = 1;
34df42f59a6022 Elen Song          2013-07-22  1224  
5483c10e03c6e3 Maxime Ripard      2014-10-22  1225  	ret = dmaengine_slave_config(atmel_port->chan_rx,
5483c10e03c6e3 Maxime Ripard      2014-10-22  1226  				     &config);
34df42f59a6022 Elen Song          2013-07-22  1227  	if (ret) {
34df42f59a6022 Elen Song          2013-07-22  1228  		dev_err(port->dev, "DMA rx slave configuration failed\n");
34df42f59a6022 Elen Song          2013-07-22  1229  		goto chan_err;
34df42f59a6022 Elen Song          2013-07-22  1230  	}
34df42f59a6022 Elen Song          2013-07-22  1231  	/*
34df42f59a6022 Elen Song          2013-07-22  1232  	 * Prepare a cyclic dma transfer, assign 2 descriptors,
34df42f59a6022 Elen Song          2013-07-22  1233  	 * each one is half ring buffer size
34df42f59a6022 Elen Song          2013-07-22  1234  	 */
34df42f59a6022 Elen Song          2013-07-22  1235  	desc = dmaengine_prep_dma_cyclic(atmel_port->chan_rx,
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1236) 					 atmel_port->rx_phys,
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1237) 					 ATMEL_SERIAL_RX_SIZE,
e51c3e1d236f8b Jiri Slaby (SUSE   2024-04-05  1238) 					 ATMEL_SERIAL_RX_SIZE / 2,
34df42f59a6022 Elen Song          2013-07-22  1239  					 DMA_DEV_TO_MEM,
34df42f59a6022 Elen Song          2013-07-22  1240  					 DMA_PREP_INTERRUPT);
c85be041065c0b Kangjie Lu         2019-03-15  1241  	if (!desc) {
c85be041065c0b Kangjie Lu         2019-03-15  1242  		dev_err(port->dev, "Preparing DMA cyclic failed\n");
c85be041065c0b Kangjie Lu         2019-03-15  1243  		goto chan_err;
c85be041065c0b Kangjie Lu         2019-03-15  1244  	}
34df42f59a6022 Elen Song          2013-07-22  1245  	desc->callback = atmel_complete_rx_dma;
34df42f59a6022 Elen Song          2013-07-22  1246  	desc->callback_param = port;
34df42f59a6022 Elen Song          2013-07-22  1247  	atmel_port->desc_rx = desc;
34df42f59a6022 Elen Song          2013-07-22  1248  	atmel_port->cookie_rx = dmaengine_submit(desc);
1e67bd2b8cb90b Tudor Ambarus      2021-11-25  1249  	if (dma_submit_error(atmel_port->cookie_rx)) {
1e67bd2b8cb90b Tudor Ambarus      2021-11-25  1250  		dev_err(port->dev, "dma_submit_error %d\n",
1e67bd2b8cb90b Tudor Ambarus      2021-11-25  1251  			atmel_port->cookie_rx);
1e67bd2b8cb90b Tudor Ambarus      2021-11-25  1252  		goto chan_err;
1e67bd2b8cb90b Tudor Ambarus      2021-11-25  1253  	}
34df42f59a6022 Elen Song          2013-07-22  1254  
4f4b9b5895614e Tudor Ambarus      2021-11-25  1255  	dma_async_issue_pending(atmel_port->chan_rx);
4f4b9b5895614e Tudor Ambarus      2021-11-25  1256  
34df42f59a6022 Elen Song          2013-07-22  1257  	return 0;
34df42f59a6022 Elen Song          2013-07-22  1258  
34df42f59a6022 Elen Song          2013-07-22  1259  chan_err:
34df42f59a6022 Elen Song          2013-07-22  1260  	dev_err(port->dev, "RX channel not available, switch to pio\n");
36ce7cff4f9361 Zheng Bin          2020-01-13  1261  	atmel_port->use_dma_rx = false;
34df42f59a6022 Elen Song          2013-07-22  1262  	if (atmel_port->chan_rx)
34df42f59a6022 Elen Song          2013-07-22  1263  		atmel_release_rx_dma(port);
34df42f59a6022 Elen Song          2013-07-22  1264  	return -EINVAL;
34df42f59a6022 Elen Song          2013-07-22  1265  }
34df42f59a6022 Elen Song          2013-07-22  1266  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
